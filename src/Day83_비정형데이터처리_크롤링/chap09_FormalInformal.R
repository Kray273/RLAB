# chap09_FormalInformal

#######################################
# chapter09. 정형 / 비정형 데이터 처리
#######################################

# 2. 비정형 데이터 처리(텍스트 마이닝 분석)

# - 텍스트 마이닝(Text Mining): 문자로 된 데이터에서 가치 있는 정보를 얻어 내는 분석 기법.

## 2.1 토픽 분석
#    - 텍스트 데이터를 대상으로 단어를 추출하고, 
#       이를 단어 사전과 비교하여 단어의 출현 빈도수를 분석하는 텍스트 마이닝 분석 과정을 의미.
#    - 또한 단어구름(word cloud) 패키지를 적용하여 분석 결과를 시각화하는 과정도 포함.
#    - 통계학에서 가장 많이 사용하는 빈도수를 사용!! 

# (1) 패키지 설치 및 준비
# 우리가 할 것은 한글 텍스트 마이닝이라 불리는 KoNLP이다! 
getwd()
setwd("C:/workspaces/RLAB/data")

install.packages("rJava") # Java를 R에서 사용하기 위한 패키지! 
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jdk-11.0.16.1')
library(rJava)

# 아래 패키지를 설치 후
install.packages("multilinguer") #한글과 관련된 패키지! 
library(multilinguer)

# 의존성을 설치 한다. # 텍스트 마이닝은 사전과 비교해서 명사인지 동사인지 파악한다, 그래서 필요한 사전등을 설치한다.
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
# 여러개를 설치하는 이유는 R의 경우 필요한 패키지를 알아서 설치해 주는데 KoNLP의 경우 업데이트가 누락되어 있다보니
# 안정된 동작을 위해 여러개를 설치해준다. 

library(stringr); library(hash); library(tau); 
library(Sejong); library(RSQLite); library(devtools); 
# error가 나면 안된다! 

# Git hub로 설치 한다. (remotes를 설치하기 위한 Git hub연동)
install.packages("remotes")
library(remotes)

remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"), force=TRUE)

# https://jar-download.com/artifacts/org.scala-lang/scala-library/2.11.8/source-code : scala-library-2.11.8.jar 다운로드
# "C:/Program Files/R/R-설치버전/library/KoNLP/java/ 폴더에 복사(scala-library-2.11.8.jar)"

library(KoNLP)

# KoNLP 테스트 예제
sentence <- '아버지가 방에 스르륵 들어가신다.'
extractNoun(sentence) # 명사를 검색하는 함수로 형태소를 분석하여 명사를 알려준다. 
# 형태소 : 문장을 분해 가능한 최소한의 단위로 분리된 것, 즉 품사별로 나눈것(Sejong이란 사전 기준) 
# [1] "아버지" "방"     "스르륵"
# 스스륵? 명사? 부사인데...? 하하 

install.packages(c("wordcloud","tm")) # 형태소분석을 시각화 해주는 wordcloud와 택스트 마이닝을 실행하는 tm
library(wordcloud); library(tm)

# (2) 텍스트 자료 가져오기
facebook <- file("facebook_bigdata.txt", encoding = "UTF-8") # 빅데이터라는 키워드로 SNS에서 긁어온것! 
# 파일을 찾아가 파일형식은 UTF-8로 변경해주기! 
facebook
# A connection with                                  
# description "facebook_bigdata.txt"
# class       "file"                
# mode        "r"                   
# text        "text"                
# opened      "closed"              
# can read    "yes"                 
# can write   "yes" 
facebook_data <- readLines(facebook) # 줄 단위 데이터 생성
head(facebook_data) # 앞부분 6줄 보기 - 줄 단위 데이터 생성
# 사진 1. 라인단위로 구분을 지어서 번호가 매겨진다. 
str(facebook_data) # chr [1:76]
close(facebook) 

# (3) 세종 사전에 신규 단어 추가
userDic <- data.frame(term=c("R 프로그래밍","페이스북","소셜네트워크","얼죽아"), tag='ncn')
# ncn은 명사라는 식별자! 

# - 신규 단어 사전 추가 함수
buildDictionary(ext_dic = 'sejong', user_dic = userDic)
# 소용시간이 걸림. 

# (4) 단어 추출을 위한 사용자 정의 함수

# - R 제공 함수로 단어 추출하기 - Sejong 사전에 등록된 신규 단어 테스트
paste(extractNoun("홍길동은 얼죽아를 최애로 생각하는, 빅데이터에 최대 관심을 가지고 있으면서, 페이스북이나 소셜네트워크로부터 생성 수집되어진 빅데이터 분석에 아주 많은 관심을 가지고 있어요."),collapse=" ")
# [1] "홍길동은 얼죽아 최애로 생각 빅데이터에 최대 관심 페이스북 소셜네트워크 생성 수집 빅데이터 분석 관심"

# 단어 추출을 위한 사용자 정의 함수 정의하기
# (1) 사용자 정의 함수 작성
#     - [문자변환]->[명사 단어 추출]->[공백으로 합침]
exNouns <- function(x){
  paste(extractNoun(as.character(x)), collapse = " ")
}

# (2) exNouns 함수 이용 단어 추출
facebook_nouns <- sapply(facebook_data, exNouns) # 명사 단어 추출.
# apply는 3개의 데이터를 받는다. 입력 매트리스 데이터-열,행 중심여부 - 함수, 입력으로 전달된 함수를 실행해서 보여준다.
# sapply는 입력된 데이터를 행렬로 반환한다. 백터
facebook_nouns[1] # 단어가 추출된 첫 줄 보기
# 사진1. 


# (5) 추출된 단어 대상 전처리 _ 1차 전처리
#  단계1: 추출된 단어 이용 말뭉치(Corpus) 생성
myCorpus <- Corpus(VectorSource(facebook_nouns)) # 택스트는 문장이여서 백터로 만들어준다. VectorSource
# tm 에서 문자열 데이터를 처리하기 위해 만든 자료형이 Corpus이다!
myCorpus
# <<SimpleCorpus>>
# Metadata:  corpus specific: 1, document level (indexed): 0
# Content:  documents: 76


#  단계2: 데이터 전처리
# tm_map은 첫번째 Corpus지료형을 매개변수로, 두 번째 기능을 매개변수로 받는다. 
myCorpusPrepro <- tm_map(myCorpus, removePunctuation) # 문장부호 제거
myCorpusPrepro <- tm_map(myCorpusPrepro,removeNumbers) # 수치 제거
myCorpusPrepro <- tm_map(myCorpusPrepro,tolower) # 소문자 변경
myCorpusPrepro <- tm_map(myCorpusPrepro,removeWords, stopwords('english')) # 불용어 제거(for, very, and, of, are)
# 전처리 결과 확인
inspect(myCorpusPrepro[1:5]) # 사진1. 실제 문자데이터를 확인! 
myCorpusPrepro[1:5]
# <<SimpleCorpus>>
# Metadata:  corpus specific: 1, document level (indexed): 0
# Content:  documents: 5

# (6) 단어 선별(단어 2음절 ~ 8음절 사이 단어 선택)하기. _2차 전처리(1음절은 보통은 의미를 가지 않는다! 보통은!)

#  - Corpus 객체를 대상으로 TermDocumentMatrix() 함수를 이용하여 분석에 필요한 단어 선별하고 단어/문서 행렬을 만든다.
#  - 전처리된 단어집에서 단어 선별(단어 2음절 ~ 8음절 사이 단어)하기.
#  - 한글 1음절은 2byte에 저장(2음절=4byte)
myCorpusPrepro_term <- TermDocumentMatrix(myCorpusPrepro, control=list(wordLengths=c(4,16)))
# 텍스트를 숫자로 표현하는 대표적인 방법. 객체를 생성!
# TermDocumentMatrix 엄밀히말하면 객체이다. 첫글자가 대문자인것으로 판단.
myCorpusPrepro_term # Corpus 객체 정보
# <<TermDocumentMatrix (terms: 696, documents: 76)>>
# Non-/sparse entries: 1256/51640
# Sparsity           : 98%
# Maximal term length: 12
# Weighting          : term frequency (tf)

# matrix 자료구조를 data.frame 자료 구조로 변경
myTerm_df <- as.data.frame(as.matrix(myCorpusPrepro_term))
dim(myTerm_df) # [1] 696  76


# (7) 단어 출현 빈도수 구하기 - 빈도수가 높은 순서대로 내림차순 정렬.
wordResult <- sort(rowSums(myTerm_df), decreasing=T) # 빈도수로 내림차순 정렬.
wordResult[1:10]
# 데이터  분석 빅데이터  처리  사용   수집   시스템 저장  결과   노드
#     91    41       33    31    29     27       23   16   14      13


# (8) 불필요한 단어 제거 시작
#   1) 데이터 전처리
myCorpusPrepro <- tm_map(myCorpus, removePunctuation) # 문장부호 제거
myCorpusPrepro <- tm_map(myCorpusPrepro,removeNumbers) # 수치 제거
myCorpusPrepro <- tm_map(myCorpusPrepro,tolower) # 소문자 변경
myStopwords <- c(stopwords('english'), "사용", "하기")
myCorpusPrepro <- tm_map(myCorpusPrepro,removeWords, myStopwords) # 불용어 제거(for, very, and, of, are)
inspect(myCorpusPrepro[1:5]) # 데이터 전처리 결과 확인

#  2) 단어 선별-단어 길이 2~8개 이상 단어 선별.
myCorpusPrepro_term <- TermDocumentMatrix(myCorpusPrepro, control=list(wordLengths=c(4,16))) # 텍스트를 숫자로 표현하는 대표적인 방법.
myCorpusPrepro_term # Corpus 객체 정보
# <<TermDocumentMatrix (terms: 694, documents: 76)>>
# Non-/sparse entries: 1231/51513
# Sparsity           : 98%
# Maximal term length: 12
# Weighting          : term frequency (tf)

# matrix 자료구조를 data.frame 자료 구조로 변경
myTerm_df <- as.data.frame(as.matrix(myCorpusPrepro_term))
dim(myTerm_df) # [1] 696  76


#  3) 단어 출현 빈도수 구하기 - 빈도수가 높은 순서대로 내림차순 정렬.
wordResult <- sort(rowSums(myTerm_df), decreasing=T) # 빈도수로 내림차순 정렬.
wordResult[1:20]

# (9) 단어 구름(wordcloud) 시각화 - 디자인 적용 전
x11() # 별도의 창을 띄우는 함수
myName <- names(wordResult) # 단어 이름 추출
wordcloud(myName, wordResult) # 단어 구름 시각화
#사진 1. 언급된 빈도수 만큼 사이즈로 구별지어 시각화 

# 단어 구름에 디자인 적용(빈도수, 색상, 위치, 회전등 )
# (1) 단어 이름과 빈도수로 data.frame 생성
word.df <- data.frame(word=myName, freq=wordResult)
str(word.df)

# (2) 단어 색상과 글꼴 지정
pal <- brewer.pal(12, "Paired") # 12가지 색상 pal
windowsFonts(malgun=windowsFont("맑은 고딕"))

# (3) 단어 구름 시각화
wordcloud(word.df$word, word.df$freq, scale = c(5,1),
          min.freq = 3, random.order = F, rot.per = .1,
          colors = pal, family="malgun")
# 사진 2. 


# 예시2) 텍스트 파일 가져오기와 단어 추출하기.
# 데이터 불러오기
txt <- readLines("hiphop.txt") # "UTF-8"로 변경. 4.2부터는 encoding을 지정하지 않아도 잘 읽어온다. 
# 멜론에서 hiphop으로 검색했을 때, 나온 노래의 가사를 저장.
head(txt)
# [1] "\"보고 싶다"                  "이렇게 말하니까 더 보고 싶다" "너희 사진을 보고 있어도"      "보고 싶다"    
# [5] "너무 야속한 시간"             "나는 우리가 밉다" 

# 특수문자 제거
txt <- str_replace_all(txt, "\\W", " ") # \W : 대문자 주의. 소문자 w는 특수문자를 검색색
head(txt)
# [1] " 보고 싶다"                   "이렇게 말하니까 더 보고 싶다" "너희 사진을 보고 있어도"      "보고 싶다"    
# [5] "너무 야속한 시간"             "나는 우리가 밉다"    


# 원하는 전처리가 제대로 됬었는지 확인하고, 그 이후 어떤 데이터 형식으로 출력 되었는지 확인해 
# 자료 구조를 역으로 파악할 수 있어야한다. 여기서는 list로 출력된다. class() 사용

# 가사에서 명사 추출
nouns <- extractNoun(txt)
nouns

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns)) #unlist() 는 list를 문자열 벡터로 변환 즉, value만 나열하겠다! 
head(wordcount); tail(wordcount) # 백터 데이터로 변환을 해야 빈도수 체크를 한다. 
# 1 100 168  17 
# 12   2   8   3   1   1 
#  
# 히   히트     힘   힘겹 힘내잔   힙합 
# 8      1     10      1      1      1

# 데이터프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F) 
# 데이터에 대한 대부분의 기능이 데이터 프레임으로 제공하고 있기에 변환함.  
# stringsAsFactors : 데이터가 문자형이면 요인형으로 변환할 것인지 묻는거. (4.0 버전 부터 기본값이 F.)
tail(df_word)
# 결과값을 보면 row의 이름을 정해주지 않아서 숫자로 자동으로 나열되고, column의 이름도 정해주지 않아 Var1으로 나옴.

# 변수명 수정
names(df_word) <- c("word", "freq") 
tail(df_word)

# 두 글자 이상 단어 추출
install.packages("dplyr") # dplyr : 전처리에 대한 다양한 기능을 탑재! 필터링/ 검색/ 정렬 등등! chap06확인
library(dplyr)

df_word <- filter(df_word, nchar(word) >= 2)
# filter : 데이터를 두번째 변수로 온 조건으로 필터링한다. 여기서는 한글자 제외!(nchar : 글자수 확인) 

top_20 <- df_word %>% # dplyr에서는 %>%(파이프 연산자)를 활용해 매서드 체이닝을 제공. (ctrl + shift + m) 
  arrange(desc(freq)) %>% # 명사 2글자 단어의 빈도수를 내림차순으로 정렬해라
  head(20) # 정렬된 명사의 상위 20개를 top_20에 넣어라. 

top_20

# 시각화
pal <- brewer.pal(8, "Dark2") # Dark2 색상 목록에서 8개  색상 추출.

# set.seed(1234)
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)
#사진 1. 

## 2.2 연관어 분석
#   : 연관규칙(Association Rule)을 적용하여 특정 단어와 연관성이 있는 단어들을 선별하여 네트워크 형태로 시각화하는 과정.

# 한글 처리를 위한 패키지 설치
# - 토픽 분석 참조.

# 텍스트 파일 가져오기와 단어 추출하기 
# 1. 텍스트 파일 가져오기
marketing <- file("marketing.txt", encoding = "UTF-8")
marketing2 <- readLines(marketing) # 줄 단위 데이터 생성
marketing2 # 방대한 양의 텍스트가 블럭단위로 출력 472개 
close(marketing)

# 2. 줄 단위 단어 추출
lword <- Map(extractNoun, marketing2) 
# 첫번째 매개변수에 함수를, 두 번째에 데이타를 넣어. 함수를 호출해서 데이터를 넣는다 라는 의미
head(lword)
length(lword) # 472
View(lword) # 사진1. 


'''
# - 참조(unique())

c1 <- rep(1:10, each=2)
c1 # 1  1  2  2  3  3  4  4  5  5  6  6  7  7  8  8  9  9 10 10

c2 <- rep(c(1, 3, 5, 7, 9), each=4)
c2 # 1 1 1 1 3 3 3 3 5 5 5 5 7 7 7 7 9 9 9 9

c3 <- c(1,1,1,1,3,3,3,3,5,5,6,6,7,7,8,8,9,10,11,12)
c3 # 1  1  1  1  3  3  3  3  5  5  6  6  7  7  8  8  9 10 11 12

c123_df <- data.frame(cbind(c1,c2,c3))
c123_df
str(c123_df) # "data.frame":	20 obs. of  3 variables:

c12_unique <- unique(c123_df[,c("c1","c2")])
c12_unique

c123_unique <- unique(c123_df[,c("c1","c2","c3")])
c123_unique

c123_unique_Last <- unique(c123_df[,c("c1","c2","c3")],fromLast=T)
c123_unique_Last
'''

lword <- unique(lword) # 공백 block 제거
length(lword) # 353

lword <- sapply(lword, unique) # 공통이 되어지는 단어들을 필터링! 
length(lword) # 353 같은 백터 데이터 안에는 공백이 없다. 

str(lword) # List of 353

# 연관어 분석을 위한 전처리 

# 1) 단어 필터링 함수 정의 - 길이가 2개 이상 4개 이하 사이의 문자 길이로 구성된 단어만 필터링.
filter1 <- function(x){
  nchar(x) >= 2 && nchar(x) <= 4 && is.hangul(x)
}

filter2 <- function(x){
  Filter(filter1, x)
}

#  2) 줄 단위로 추출된 단어 전처리
lword <- sapply(lword, filter2) # 단어 길이가 1이하 또는 5 이상인 단어 제거.
lword # 사진1. 


# 트랜잭션 생성
#  - 트랜잭션: 연관분석에서 사용되는 데이터 처리 단위. 위의 Corpus지료형과 같은 개념이다. 
#  - 연관분석을 위해서는 추출된 단어를 대상으로 트랜잭션 형식으로 자료구조 변환.

# 1) 연관 분석을 위한 패키지 설치
install.packages("arules")
library(arules)

# 2) 트랜잭션 생성
wordtran <- as(lword, "transactions") # as()는 as(~처럼)가 아니다! Association(연관)이라는 뜻이다.
wordtran
# transactions in sparse format with
# 353 transactions (rows) and
# 2424 items (columns)
 
# 3) 교차표 작성: crossTable() -> 교차테이블 함수를 이용. #chap12 참조. 
wordtable <- crossTable(wordtran) # crossTable()을 이용해 자동 정렬해서 나열하고 있다. 자료형은 트랜젝션이다. 
# gmoduls 패키지에서 제공되는 CrossTable과 다른다. 
wordtable
#사진1.

# 4) 단어 간 연관 규칙 산출
tranrules <- apriori(wordtran,parameter=list(support=0.25, conf=0.05))
tranrules
# writing ... [59 rule(s)] done [0.00s]. 컴퓨터가! 59개의 규칙을 발견했다!

# 5) 연관 규칙 생성 결과 보기
inspect(tranrules)
# 사진2. 

# 연관어 시각화
# 1) 연관 단어 시각화를 위해서 자료 구조 변경
rules <- labels(tranrules, ruleSep=" ") # 연관규칙 레이블을 " "으로 분리
head(rules, 20)
class(rules) # "character"

# 2) 문자열로 묶인 연관 단어를 행렬 구조 변경.
rules <- sapply(rules, strsplit, " ", USE.NAMES = F)
rules
class(rules) # "list" 사진 1. 

# 3) 행 단위로 묶어서 matrix로 반환
rulemat <- do.call("rbind", rules) #chap2 do.call은 다차원의 리스트를 matrix로 반환! cbind도 인수를 지정할 수 있음(열 단위).
rulemat
class(rulemat) # "matrix"

# 연관어 시각화를 위한 igraph 패키지 설치
install.packages("igraph")
library(igraph)

# edgelist 보기 - 연관 단어를 정점(Vertex) 형태의 목록 제공
ruleg <- graph.edgelist(rulemat[c(12:59),], directed = F) #[1,]~[11,] "{}" 제외
ruleg
#사진2. 

# edgelist 시각화
x11()
plot.igraph(ruleg,vertex.label=V(ruleg)$name,
            vertex.label.cex=1.2, vertex.label.color='black',
            vertex.size=20, vertex.color='green',
            vertex.frame.color='blue') # 사진3. 

# 3. 실시간 뉴스 수집과 분석

# 3.1 관련 용어

#  (1) 웹크롤링(web crawling)
#   - 웹을 탐색하는 컴퓨터 프로그램(크롤러)을 이용하여 여러 인터넷 사이트의 웹 페이지 자료를 수집해서 분류하는 과정.
#   - 또한 크롤러(crawler)란 자동화된 방법으로 월드와이드웹(www)을 탐색하는 컴퓨터 프로그램을 의미.

#  (2) 스크래핑(scraping)
#   - 웹사이트의 내용을 가져와 원하는 형태로 가공하는 기술.
#   - 즉, 웹사이트의 데이터를 수집하는 모든 작업을 의미.
#   - 결국, 크롤링도 스크래핑 기술의 일종.
#   - 크롤링과 스크래핑을 구분하는 것은 큰 의미가 없음.

#  (3) 파싱(parsing)
#   - 어떤 페이지(문서, HTML등)에서 사용자가 원하는 데이터를 특정 패턴이나 순서로 추출하여 정보를 가공하는 것.
#   - 예를들면 HTML 소스를 문자열로 수집한 후 실제 HTML 태그로 인식할 수 있도록 문자열을 의미있는 단위로 분해하고, 계층적인 트리 구조를 만드는 과정.

# 3.2 실시간 뉴스 수집과 분석

#  (1) 패키지 설치 및 준비
# 실습: 웹 문서 요청과 파싱 관련 패키지 설치 및 로딩
install.packages("httr")
library(httr)
install.packages("XML")
library(XML)


# 실습: 웹 문서 요청
url <- "https://news.daum.net"
web <- GET(url)
web

# 실습: HTML 파싱하기
html <- htmlTreeParse(web, useInternalNodes = T, trim = T, encoding = "utf-8")
rootNode <- xmlRoot(html)
html

# 실습: 태그 자료 수집하기
news <- xpathSApply(rootNode, "//a[@class = 'link_txt']", xmlValue)
news


# 실습: 자료 전처리하기
# 단계 1: 자료 전처리 - 수집한 문서를 대상으로 불용어 제거
news_pre <- gsub("[\r\n\t]", ' ', news)
news_pre <- gsub('[[:punct:]]', ' ', news_pre)
news_pre <- gsub('[[:cntrl:]]', ' ', news_pre)
# news_pre <- gsub('\\d+', ' ', news_pre)   # corona19(covid19) 때문에 숫자 제거 생략
news_pre <- gsub('[a-z]+', ' ', news_pre)
news_pre <- gsub('[A-Z]+', ' ', news_pre)
news_pre <- gsub('\\s+', ' ', news_pre)

news_pre

# 단계 2: 기사와 관계 없는 'TODAY', '검색어 순위' 등의 내용은 제거
news_data <- news_pre[1:32] # 검색수 만큼 변경 
news_data


# 실습: 수집한 자료를 파일로 저장하고 읽기
write.csv(news_data, "C:/workspaces/Rwork/output/news_data.csv", quote = F)

news_data <- read.csv("C:/workspaces/Rwork/output/news_data.csv", header = T, stringsAsFactors = F)
str(news_data)

names(news_data) <- c("no", "news_text")
head(news_data)

news_text <- news_data$news_text
news_text

# 실습: 세종 사전에 단어 추가
user_dic <- data.frame(term = c("이태원역", "탄도미사일", "이태원"), tag = 'ncn')
buildDictionary(ext_dic = 'sejong', user_dic = user_dic)

# 실습: 단어 추출 사용자 함수 정의하기
# 단계 1: 사용자 정의 함수 작성
exNouns <- function(x) { paste(extractNoun(x), collapse = " ")}

# 단계 2: exNouns()  함수를 이용하어 단어 추출
news_nouns <- sapply(news_text, exNouns)
news_nouns

# 단계 3: 추출 결과 확인
str(news_nouns)

# 실습: 말뭉치 생성과 집계 행렬 만들기
# 단계 1: 추출된 단어를 이용한 말뭉치(corpus) 생성
newsCorpus <- Corpus(VectorSource(news_nouns))
newsCorpus
#<<SimpleCorpus>>
#Metadata:  corpus specific: 1, document level (indexed): 0
#Content:  documents: 32
inspect(newsCorpus)

# 단계 2: 단어 vs 문서 집계 행렬 만들기
# 한글 2~8 음절 단어 대상 단어/문서 집계 행렬 
TDM <- TermDocumentMatrix(newsCorpus, control = list(wordLengths = c(4, 16)))
TDM

# 단계 3: matrix 자료구조를 data.frame 자료구조로 변경
tdm.df <- as.data.frame(as.matrix(TDM))
dim(tdm.df)


# 실습: 단어 출현 빈도수 구하기
wordResult <- sort(rowSums(tdm.df), decreasing = TRUE)
wordResult[1:10]


# 실습: 단어 구름 생성
# 단계 1: 패키지 로딩과 단어 이름 추출
library(wordcloud)
myNames <- names(wordResult)
myNames


# 단계 2: 단어와 단어 빈도수 구하기
df <- data.frame(word = myNames, freq = wordResult)
head(df)

# 단계 3: 단어 구름 생성
pal <- brewer.pal(12, "Paired")
x11()
wordcloud(df$word, df$freq, min.freq = 2,
          random.order = F, scale = c(4, 0.7),
          rot.per = .1, colors = pal)



