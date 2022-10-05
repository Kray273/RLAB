# chap03_DataIO

######################################
# chapter03. 데이터 입출력
######################################

# 1. 데이터 불러오기

## 1-1. 키보드 입력

# 키보드로 숫자 입력하기
num <- scan()
# 1: 10
# 2: 20
# 3: 30
# 4: 
#   Read 3 items
num
# [1] 10 20 30

# 합계 구하기
sum(num)
# [1] 60

# 키보드로 문자 입력하기
name <- scan(what = character()) 
# 1: 홍길동
# 2: 이순신
# 3: 강감친
# 4: 
#   Read 3 items
name
# [1] "홍길동" "이순신" "강감친"

# 편집기 이용 데이터프레임 만들기
df <- data.frame() #빈 데이터프레임 생성
df <- edit(df) #입력창이 뜸.
df
#   name age
# 1 hong  30
# 2 kang  30

## 1-2. 로컬 파일 가져오기

# 1) read.table() 함수 이용
#   - 컬럼명이 없는 파일 불러오기
getwd()
setwd("C:/workspaces/RLAB/data")

student <- read.table(file = "student.txt")
student
#    V1   V2  V3 V4
# 1 101 hong 175 65
# 2 201  lee 185 85
# 3 301  kim 173 60
# 4 401 park 180 70
mode(student); class(student)
# [1] "list"
# [1] "data.frame"

names(student) <- c('번호', '이름', '키', '몸무게')
student
#    번호 이름  키 몸무게
# 1  101 hong 175     65
# 2  201  lee 185     85
# 3  301  kim 173     60
# 4  401 park 180     70

#   - 컬럼명이 있는 파일 불러오기
student1 <- read.table("student1.txt",header = T, encoding = "UTF-8")
student1
#   번호 이름  키 몸무게
# 1  101 hong 175     65
# 2  201  lee 185     85
# 3  301  kim 173     60
# 4  401 park 180     70

#   - 탐색기를 통해서 파일 선택하기
student1 <- read.table(file.choose(), header = T)
student1  
#   번호 이름  키 몸무게
# 1  101 hong 175     65
# 2  201  lee 185     85
# 3  301  kim 173     60
# 4  401 park 180     70

#   - 구분자가 있는 경우(세미콜론, 탭)
student2 <- read.table("student2.txt", header = T, sep = ";",encoding = "UTF-8")
student2
#    번호 이름  키 몸무게
# 1  101 hong 175     65
# 2  201  lee 185     85
# 3  301  kim 173     60
# 4  401 park 180     70

#   - 결측치를 처리하여 파일 불러오기
student3 <- read.table("student3.txt", header = T, na.strings = "-", encoding = "UTF-8") 
# 문자열 -> NA처리
student3
#   번호 이름  키 몸무게
# 1  101 hong 175     65
# 2  201  lee 185     85
# 3  301  kim 173     NA
# 4  401 park  NA     70

#   - csv 파일 형식 불러오기
student4 <- read.csv(file = "student4.txt", na.strings = "-", encoding = "UTF-8")
student4
#    번호 이름   키 몸무게
# 1  101 hong  175      +
# 2  201  lee    $     85
# 3  301  kim  173   <NA>
# 4  401 park <NA>     70

# read.xlsx() 함수 이용 - 엑셀데이터 읽어오기
# 패키지 설치와 java 실행 환경 설정
install.packages("rJava") # rJava 패키지 설치
install.packages("xlsx")  # xlsx 패키지 설치
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jdk-11.0.16.1')

# 관련 패키지 메모리 로드
library(rJava)
library(xlsx)

# 엑셀 파일 가져오기
studentex <- read.xlsx("studentexcel.xlsx", encoding = "UTF-8", sheetIndex = 1)
studentex
#    학번   이름 성적 평가
# 1  101 홍길동   80    B
# 2  102 이순신   95   A+
# 3  103 강감찬   78   C+
# 4  104 유관순   85   B+
# 5  105 김유신   65   D+

install.packages("readxl")
library(readxl)
st_excel <- read_excel(path = "studentexcel.xlsx", sheet = 1)
st_excel
# # A tibble: 5 x 4
#      학번 이름    성적 평가 
#     <dbl> <chr>  <dbl> <chr>
#   1   101 홍길동    80 B    
#   2   102 이순신    95 A+   
#   3   103 강감찬    78 C+   
#   4   104 유관순    85 B+   
#   5   105 김유신    65 D+

## 1-3. 인터넷에서 파일 가져오기

# 단계1 : 세계 GDP 순위 데이터 가져오기
GDP_ranking <- read.csv("https://databank.worldbank.org/data/download/GDP.csv", encoding = "UTF-8")
GDP_ranking
head(GDP_ranking, 20)
dim(GDP_ranking)

# 데이터를 가공하기 위해 불필요한 행과 열을 제거한다.
GDP_ranking2 <- GDP_ranking[-c(1:4), c(1,2,4,5)]
head(GDP_ranking2)
#   X.U.FEFF. Gross.domestic.product.2021            X.1          X.2
# 5        USA                           1  United States  22,996,100 
# 6        CHN                           2          China  17,734,063 
# 7        JPN                           3          Japan   4,937,422 
# 8        DEU                           4        Germany   4,223,116 
# 9        GBR                           5 United Kingdom   3,186,860 
# 10       IND                           6          India   3,173,398 

# 상위 16개 국가 선별한다.
GDP_ranking16 <- head(GDP_ranking2, 16) # 상위 16개 국가
GDP_ranking16

# 데이터프레임을 구성하는 4개의 열에 대한 이름을 지정한다.
names(GDP_ranking16) <- c('Code', 'Ranking', 'Nation', 'GDP')
GDP_ranking16
dim(GDP_ranking16)

# 단계2 : 세계 GDP 상위 16위 국가 막대 차트 시각화
gdp <- GDP_ranking16$GDP
nation <- GDP_ranking16$Nation
gdp

install.packages("stringr")
library(stringr)
num_gdp <- as.numeric(str_replace_all(gdp, ',', ''))
num_gdp

GDP_ranking16$GDP <- num_gdp


# 막대차트 시각화
barplot(GDP_ranking16$GDP, col = rainbow(16),
        xlab = '국가(nation)', ylab='단위(달러)', names.arg=nation)
#사진1.

# 1,000단위 축소
num_gdp2 <- num_gdp / 1000
GDP_ranking16$GDP2 <- num_gdp2
barplot(GDP_ranking16$GDP2, col = rainbow(16),
        main = "2021년도 GDP 세계 16위 국가",
        xlab = '국가(nation)', ylab='단위(천달러)', names.arg=nation)
#사진2.
GDP_ranking16


## 1-4. 웹문서 가져오기

# 2010년 ~ 2015년도 미국의 주별 1인당 소득 자료 가져오기.
# "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

# 단계1 : XML / httr 패키지 설치
install.packages("XML")
install.packages("httr")

library(XML)
library(httr)

# 단계2 : 미국의 주별 1인당 소득 자료 가져오기.
url <- "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

# 단계3 : 전처리 
get_url <- GET(url)#정보를 읽어온다.
get_url$content #메모리에 담겨져 있는 16진수 그대로 읽어옴.
rawToChar(get_url$content) #소스코드로 변환
html_cont <- readHTMLTable(rawToChar(get_url$content), stringsAsFactors=F) 
class(html_cont) #list

html_cont <- as.data.frame(html_cont) #list를 data.frame으로 형변환
class(html_cont) #data.frame
head(html_cont)


# 단계4 : 컬럼명을 수정한 후 뒷부분 6개 관측치 보기
names(html_cont) <- c("State","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015")
tail(html_cont)
#op
#    State   Y2010   Y2011   Y2012   Y2013   Y2014   Y2015
# 47       Vermont $40,066 $42,735 $44,287 $44,839 $46,428 $47,864
# 48      Virginia $45,412 $47,689 $49,320 $48,956 $50,345 $52,136
# 49    Washington $42,821 $44,800 $47,344 $47,468 $49,610 $51,146
# 50 West Virginia $32,104 $34,211 $35,374 $35,163 $36,132 $37,047
# 51     Wisconsin $38,815 $40,837 $42,463 $42,737 $44,186 $45,617
# 52       Wyoming $44,846 $49,140 $52,154 $51,791 $54,584 $55,303


# 2. 데이터 저장하기
# 2-1. 화면(콘솔) 출력
#  1) cat() 함수
x <-  10
y <-  20 
z <-  x * y
cat("x * y의 결관는 ",z,"입니다.\n")
# x * y의 결관는  200 입니다.

#  2) print() 함수
print(z) # 변수 
# [1] 200
print(z * 10)#수식
# [1] 2000
print("x*y=",z) # error 문자는 출력 못함. 


# 2-2. 파일에 데이터 저장
#  1) sink() 함수를 이용한 파일 저장
getwd()
setwd("C:/workspaces/RLAB/outputs")

install.packages("RSADBE")
library(RSADBE)
data("Severity_Counts") # Severity_Counts 데이터 셋 가져오기
Severity_Counts
# Bugs.BR       Bugs.AR    NT.Bugs.BR    NT.Bugs.AR      Major.BR      Major.AR   Critical.BR   Critical.AR 
# 11605           374         10119            17          1135            35           432            10 
# H.Priority.BR H.Priority.AR 
# 459             3 

sink("severity.txt") # 저장할 파일 open
severity <- Severity_Counts # 데이터 셋을 변수에 저장.
severity  # 콘솔에 출력되지 않고, 파일에 저장
#사진3.
sink()    # 오픈된 파일 close

install.packages("xlsx")
library(xlsx)
#  2) write.table() 함수 이용 파일 저장
# 탐색기를 이용하여 데이터 가져오기
studenttx <- read.xlsx(file.choose(), sheetIndex = 1, encoding = "UTF-8")
studenttx

# 기본 속성으로 저장 - 행이름과 따옴표가 붙는다.
write.table(studenttx, "stdt.txt")
#사진4
# 'row.names=F' 속성을 이용하여 행이름 제거하여 저장한다.
write.table(studenttx, "stdt2.txt", row.names = F)
#사진5
# 'quote=F' 속성을 이용하여 따옴표를 제거하여 저장한다.
write.table(studenttx, "stdt3.txt", quote = F)
#사진6

# 행이름 제거 + 따옴표 제거
write.table(studenttx, "stdt4.txt", quote = F, row.names = F)
#사진7

GDP_ranking16
write.table(GDP_ranking16, "GDP_ranking16.txt", row.names = F)

GDP_ranking16_read <- read.table("GDP_ranking16.txt", sep = "", header = T)
GDP_ranking16_read

#  3) write.xlsx() 함수 이용 파일 저장 - 엑셀 파일로 저장
library(rJava)
library(xlsx) # excel data 입출력 함수 제공

st.df <- read.xlsx(file.choose(),sheetIndex = 1, encoding = "UTF-8")
st.df

write.xlsx(st.df, "studentx.xlsx") #excel형식으로 저장장


#  4) write.csv() 함수 이용 파일 저장
#     - data.frame 형식의 데이터를 csv 형식으로 저장.

write.csv(st.df, "st.df.csv", row.names = F, quote = F)









