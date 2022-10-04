# chap02_DataStructure

######################################
# chapter02. 데이터의 유형과 구조
######################################

# 1. Vector 자료 구조
##  - C() 함수 이용 벡터 객체 생성
x <- c(1, 2, 3, 4, 5) # combine 함수
x
# op -> [1] 1 2 3 4 5

x <- c(1:20) # 콜론 : 범위
x
# op -> [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

y <- 10:20 #combine 생략가능! 
y
# op -> [1] 10 11 12 13 14 15 16 17 18 19 20

##  - seq() 함수 이용 벡터 객체 생성
x <- seq(1, 10, 2) #sequence(시작값, 종료, 증감)
x
# op -> [1] 1 3 5 7 9


##  - rep() 함수 이용 벡터 객체 생성
help(rep) # ?rep
example(rep)
rep(1:3, 3) # replicate(대상, 반복수)
# op -> [1] 1 2 3 1 2 3 1 2 3
rep(1:3, each=3)
# op -> [1] 1 1 1 2 2 2 3 3 3

# union(), setdiff(), intersect() 함수 이용
x <- c(1, 3, 5, 7)
y <- c(3, 5)
x; y
# op -> 
# [1] 1 3 5 7
# [1] 3 5


union(x, y)     # 합집합(x+y)
# op -> [1] 1 3 5 7
setdiff(x, y)   # 차집합(x-y)
# op ->  [1] 1 7
intersect(x, y) # 교집합(x^y)
# op -> [1] 3 5

# 숫자형, 문자형, 논리형 벡터 생성
v1 <- c(33, -5, 20:23, 12, -2:3)
v1
# op -> [1] 33 -5 20 21 22 23 12 -2 -1  0  1  2  3
v2 <- c(33, -5, 20:23, 12, "4") # 데이터를 모두 문자형으로 변환.
v2
# op -> [1] "33" "-5" "20" "21" "22" "23" "12" "4"


# 한 줄에 명령문 중복 사용
v1; mode(v1) #mode  : 자료형을 반환
# op ->
# [1] 33 -5 20 21 22 23 12 -2 -1  0  1  2  3
# [1] "numeric"
v2; mode(v2)

# 벡터에 컬럼명 지정
age <- c(30,35,40)
age
# op -> [1] 30 35 40
names(age) <- c("홍길동","이순신","강감찬")
age
# op ->
# 홍길동 이순신 강감찬 
# 30     35     40 
age <-NULL # 초기화!!
age
# op -> NULL

# 벡터 자료 참조하기
a <- c(1:50)
a
# op -> 
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34
# [35] 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50

a[10] # Java와 다르게 index가 1 부터 카운트!! 
# op -> [1] 10
a[c(10:15)]
# op -> [1] 10 11 12 13 14 15
a[c(10,20,30,40)]
# op -> [1] 10 20 30 40
a[10:(length(a)-30)]
# op -> [1] 10 11 12 13 14 15 16 17 18 19 20

# 잘못된 벡터 첨자 사용 예
a[5,10]
# op -> Error in a[5, 10] : incorrect number of dimensions
# c는 :과 같이 사용할 때 생략이 가능. 
# 에러의 이유는 나중에! -   matric! dimensions!!

# c() 함수에서 콤마 사용 예
v1 <- c(33, -5, 20:23, 12, -2:3)
v1
# op -> [1] 33 -5 20 21 22 23 12 -2 -1  0  1  2  3
v1[1]
# op -> [1] 33
v1[c(2,6)]
# op -> [1] -5 23
v1[3:5]
# op -> [1] 20 21 22
v1[c(1,3:5,8)]

# 음수 값으로 첨자 지정 예
v1[-1] #앞에서 부터 해당 자리를 뺴고 출력
# op -> [1] -5 20 21 22 23 12 -2 -1  0  1  2  3
v1[-2]
# op -> [1] 33 20 21 22 23 12 -2 -1  0  1  2  3
v1[-c(2:6)]
# op -> [1] 33 12 -2 -1  0  1  2  3


# 패키지 설치와 메모리 로딩
install.packages("RSADBE") # 패키지(데이터) 설치
library(RSADBE)            # 패키지를 메모리에 로드

data("Severity_Counts")    # RSADBE 패키지에서 제공되는 데이터 셋 가져오기.
str(Severity_Counts)
# op ->
# Named num [1:10] 11605 374 10119 17 1135 ...
# - attr(*, "names")= chr [1:10] "Bugs.BR" "Bugs.AR" "NT.Bugs.BR" "NT.Bugs.AR" ...

# 패키지에서 제공되는 벡터데이터 셋 보기
Severity_Counts
# op ->
# Bugs.BR       Bugs.AR    NT.Bugs.BR    NT.Bugs.AR      Major.BR      Major.AR   Critical.BR 
# 11605           374         10119            17          1135            35           432 
# Critical.AR H.Priority.BR H.Priority.AR 
# 10           459             3 


# 2. Matrix 자료 구조
args(matrix)
# 벡터 이용 행렬 객체 생성
m <- matrix(c(1:5))
m  # 5행 1열
# op ->
#       [,1]  열
# [1,]    1   행 
# [2,]    2 
# [3,]    3
# [4,]    4
# [5,]    5

# 벡터의 열 우선으로 행렬 객체 생성
?matrix
m <- matrix(c(1:10), nrow = 2) # 2행 5열
m
# op ->
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    1    3    5    7    9
# [2,]    2    4    6    8   10

# 행과 열의 수가 일치하지 않는 경우 예
m <- matrix(c(1:11), nrow = 2)
# op ->
# Warning message:
#   In matrix(c(1:11), nrow = 2) :
#   data length [11] is not a sub-multiple or multiple of the number of rows [2]
m
# op -> 숫자를 반복해서 넣어줌.
#     [,1] [,2] [,3] [,4] [,5] [,6]
# [1,]    1    3    5    7    9   11
# [2,]    2    4    6    8   10    1

# 벡터의 행 우선으로 행렬 객체 생성
m <- matrix(c(1:10), nrow = 2, byrow = T)
m
# op -> 행 우선으로 
#       [,1] [,2] [,3] [,4] [,5]
# [1,]    1    2    3    4    5
# [2,]    6    7    8    9   10

m <- matrix(c(1:10),  byrow = T) # 주의 - 여전히 10행 1열로 만들어짐.
m # nrow/ncol 값이 주어지지 않으면, default는 one-column으로 동작.
# op -> 
#       [,1]
# [1,]    1
# [2,]    2
# [3,]    3
# [4,]    4
# [5,]    5
# [6,]    6
# [7,]    7
# [8,]    8
# [9,]    9
# [10,]   10

m <- matrix(c(1:10),  ncol = 10)
m
# op ->
#       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
# [1,]    1    2    3    4    5    6    7    8    9    10

# 행 묶음으로 행렬 객체 생성
x1 <- c(5,40,50:52)
x2 <- c(30, 5, 6:8)
mr <- rbind(x1,x2)
mr
# op ->
#     [,1] [,2] [,3] [,4] [,5]
# x1    5   40   50   51   52
# x2   30    5    6    7    8


# 열 묶음으로 행렬 객체 생성
mc <- cbind(x1,x2)
mc
# op ->
#       x1 x2
# [1,]  5 30
# [2,] 40  5
# [3,] 50  6
# [4,] 51  7
# [5,] 52  8

# 2행으로 행렬 객체 생성
m3 <- matrix(c(10:19),nrow = 2)
m3
# op ->
#       [,1] [,2] [,3] [,4] [,5]
# [1,]   10   12   14   16   18
# [2,]   11   13   15   17   19


# 자료와 객체 type 보기
mode(m3); class(m3) # 자료형 확인;객체 type 확인
# op ->
# [1] "numeric" 
# [1] "matrix" "array" 

# 행렬 객체에 첨자로 접근
# java의 경우 int[][] num = new int[2][5];로 설정하고 
# num[1][2] = 15;로 값을 넣음. [열][행]
m3[2,3] # 2행 3열의 데이터 
# op -> [1] 15
m3[1,] # 행만 출력
# op -> [1] 10 12 14 16 18
m3[,5] # 열만 출력
# op -> [1] 18 19
m3[1,c(2:4)] # 1행에서 2~4열 데이터
# op -> [1] 12 14 16
m3[1,c(2,4)] # 1행에서 2,4열 데이터
# op -> [1] 12 16


#` 3행 3열로 행렬 객체 생성
x <- matrix(c(1:9),nrow = 3, ncol = 3)
x <- matrix(c(1:9),nr = 3, nc = 3) #매개변수이름은 구별이 가는 선에서 요약가능
x
# op ->
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9

#x <- matrix(c(1:9),n = 3, n = 3) 이건 허용이 안됨.

# 자료의 개수 보기
length(x) # 데이터 개수
# op -> [1] 9
ncol(x); nrow(x) # 열 / 행 수
# op -> 
# [1] 3
# [1] 3

# apply() 함수 적용
apply(x, 1, max) #두번쨰 매개변수는 1은 행, 2은 열을 의미, max는 최대값.
# op -> [1] 7 8 9
apply(x, 1, min) # min은 최소값
# op -> [1] 1 2 3
apply(x, 2, mean) # 열 단위의 평균값
# op -> [1] 2 5 8

################################################

# 사용자 정의 적용
f <-  function(x){ # x : 매개변수
  x * c(1,2,3)
}

# 행 우선 순서로 사용자 정의 함수 적용
result <- apply(x,1,f)
result
# op ->
#       [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    8   10   12
# [3,]   21   24   27

# 열 우선 순서로 사용자 정의 함수 적용
result <- apply(x,2,f)
result
# op ->
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    4   10   16
# [3,]    9   18   27


# 행렬 객체에 컬럼명 지정하기
colnames(x) <-  c('one','two','three')
x
# op ->
#       one two three
# [1,]   1   4     7
# [2,]   2   5     8
# [3,]   3   6     9


## 3. Array 자료 구조

# 3차원 배열 객체 생성하기
vec <- c(1:12) # 12개 벡터 객체 생성
arr <- array(vec,c(3,2,2)) #3행 2열 2면 -> 3차원 배열 객체 생성
arr
# op ->
# , , 1
# 
#       [,1] [,2]
# [1,]    1    4
# [2,]    2    5
# [3,]    3    6
# 
# , , 2
# 
#       [,1] [,2]
# [1,]    7   10
# [2,]    8   11
# [3,]    9   12



# 3차원 배열 객체 자료 조회
arr[2,1,2] # 행,열,면  8을 조회
# op- > [1] 8
arr[,,1] #1면 전체
# op- >
#       [,1] [,2]
# [1,]    1    4
# [2,]    2    5
# [3,]    3    6
arr[2,,1] # 1면의 2행
# op- > [1] 2 5

# 배열 자료형과 자료 구조
mode(arr); class(arr)
# op- > 
# [1] "numeric"
# [1] "array"

# 데이터 셋 가져오기
library(RSADBE)
data(Bug_Metrics_Software)
str(Bug_Metrics_Software)

# 데이터 셋 자료보기
Bug_Metrics_Software



## 4. List 자료 구조

# key를 이용하여 value에 접근하기
member <- list(name=c("헝길동","항길동"),
               age=c(35,23),
               address=c("서울","경기"),
               gender=c("여자","남자"),
               htype=c("아파트","오피스텔")
               )
member
#  op ->  R은 Java와 다르게 . 이 아닌 $로 접근
# $name 
# [1] "헝길동" "항길동"
# 
# $age
# [1] 35 23
# 
# $address
# [1] "서울" "경기"
# 
# $gender
# [1] "여자" "남자"
# 
# $htype
# [1] "아파트"   "오피스텔"


# key를 이용하여 value에 접근하기
member$name
#  op ->  [1] "헝길동" "항길동"
member$name[1]
#  op ->  [1] "헝길동"
member$name[3] <- "이순신" #데이터 추가 기능.
member$name[3]
#  op ->  [1] "이순신"

member$age <- 45 #데이터 수정 시(주의  - 하나의 값으로 수정 X)
member
#  op -> [1] 45  전체 데이터가 하나로 수정
# $name
# [1] "헝길동" "항길동" "이순신"
# 
# $age
# [1] 45
# 
# $address
# [1] "서울" "경기"
# 
# $gender
# [1] "여자" "남자"
# 
# $htype
# [1] "아파트"   "오피스텔"

member$id <-c("hong","you") #데이터 추가
member
#  op -> $id가 추가
# $name
# [1] "헝길동" "항길동" "이순신"
# 
# $age
# [1] 45
# 
# $address
# [1] "서울" "경기"
# 
# $gender
# [1] "여자" "남자"
# 
# $htype
# [1] "아파트"   "오피스텔"
# 
# $id
# [1] "hong" "you" 

member$age <- NULL #데이터 제거
member
#  op -> $age가 출력이 안됨
# $name
# [1] "헝길동" "항길동" "이순신"
# 
# $address
# [1] "서울" "경기"
# 
# $gender
# [1] "여자" "남자"
# 
# $htype
# [1] "아파트"   "오피스텔"
# 
# $id
# [1] "hong" "you"



# 1개 값을 갖는 리스트 객체 생성
list <- list("lee","이순신",35) 
list
#  op -> 키값이 없으면 이름 없이 출력
# """
# op
# [[1]] --------------------> key(생략)[[n]]
# [1] lee-----------------> value[n]
# 
# [[2]]
# [1] 이순신
# 
# [[3]]
# [1] 35
# """

# 1개 이상의 값을 갖는 리스트 객체 생성
num <-list(c(1:5),c(6:10))
num
# """ 
# op
# [[1]]
# [1] 1 2 3 4 5
# 
# [[2]]
# [1]  6  7  8  9 10
# """

# 리스트 자료구조 -> 벡터 구조로 변경하기
unlist <- unlist(num)
unlist
# """ 
# op
# [1]  1  2  3  4  5  6  7  8  9 10
# """

# 리스트 객체에 함수 적용하기
# list data 처리 함수
a <- list(c(1:5)) 
b <- list(c(6:10))
a; b
# op
# [[1]]
# [1] 1 2 3 4 5
# 
# [[1]]
# [1]  6  7  8  9 10

c(a,b) # 하나의 데이터로 출력
# op
# [[1]]
# [1] 1 2 3 4 5
# 
# [[2]]
# [1]  6  7  8  9 10

c <- lapply(c(a,b), max) # list로 결과반환
c
# op
# [[1]]
# [1] 5
# 
# [[2]]
# [1] 10

mode(c); class(c)  # op -> "list" "list"

# 리스트 형식을 벡터 형식으로 반환하기
c <- sapply(c(a,b), max)
c
# op -> [1]  5 10
mode(c); class(c) # op -> "numeric" "integer"

# 다차원 리스트 객체 생성
multi_list <- list(list(1,2,3),list(10,20,30),list(100,200,300))
multi_list
# op 
# [[1]]       ----> key값이 없어서 대괄호로 표시
# [[1]][[1]]  -----> list안에 list임으로 두개를 표시
# [1] 1
# 
# [[1]][[2]]
# [1] 2
# 
# [[1]][[3]]
# [1] 3
# 
# 
# [[2]]
# [[2]][[1]]
# [1] 10
# 
# [[2]][[2]]
# [1] 20
# 
# [[2]][[3]]
# [1] 30
# 
# 
# [[3]]
# [[3]][[1]]
# [1] 100
# 
# [[3]][[2]]
# [1] 200
# 
# [[3]][[3]]
# [1] 300
multi_list <- list(c1=list(1,2,3),c2=list(10,20,30),c3=list(100,200,300))
multi_list
# op 키값을 가지고 출력
# $c1
# $c1[[1]]
# [1] 1
# 
# $c1[[2]]
# [1] 2
# 
# $c1[[3]]
# [1] 3
# 
# 
# $c2
# $c2[[1]]
# [1] 10
# 
# $c2[[2]]
# [1] 20
# 
# $c2[[3]]
# [1] 30
# 
# 
# $c3
# $c3[[1]]
# [1] 100
# 
# $c3[[2]]
# [1] 200
# 
# $c3[[3]]
# [1] 300

multi_list$c1
multi_list$c2
multi_list$c3
# op 
# [[1]]
# [1] 100
# 
# [[2]]
# [1] 200
# 
# [[3]]
# [1] 300
mode(multi_list); class(multi_list)
# op
# [1] "list"
# [1] "list"

# 다차원 리스트를 열 단위로 바인딩
d <- do.call(cbind, multi_list)
d
# op
#       c1 c2 c3 
# [1,] 1  10 100
# [2,] 2  20 200
# [3,] 3  30 300
class(d) # [1] "matrix" "array" 



## 5. Data Frame 자료 구조

# 벡터 이용 객체 생성
no  <- c(1, 2, 3)
name <- c("홍길동","이순신","강감찬")
pay <- c(150,250,300)
vemp <- data.frame(No=no,Name=name,Pay=pay)
vemp
# op 
#    No   Name Pay
# 1  1 홍길동 150
# 2  2 이순신 250
# 3  3 강감찬 300
class(vemp) # "data.frame"

# matrix 이용 객체 생성
args(matrix) # 구조 확인
m <- matrix(c(1,"홍길동",150,
              2,"이순신",250,
              3,"강감찬",300), 3, byrow = T)
m
#op 동일한 자료형으로 저장
#       [,1] [,2]     [,3] 
# [1,] "1"  "홍길동" "150"
# [2,] "2"  "이순신" "250"
# [3,] "3"  "강감찬" "300"

class(m)
#op -> [1] "matrix" "array" 

memp <- data.frame(m)
memp
#op 데이터 프레임의 형변환이 가능.
#    X1     X2  X3
# 1  1 홍길동 150
# 2  2 이순신 250
# 3  3 강감찬 300
class(memp)
# op-> [1] "data.frame"

# txt 파일 이용 객체 생성
getwd()
setwd("C:/workspaces/RLAB/data")

txtemp <- read.table('emp.txt', header = T, sep = "") 
#컬럼에 이름이 있으면 header를 T로, 데이터에 여백이 있으면 seq=""
txtemp 
#op
#   사번 이름 급여
# 1  101 hong  150
# 2  201  lee  250
# 3  301  kim  300
class(txtemp)
#op ->[1] "data.frame"


# csv 파일 이용 객체 생성(header=T)
csvtemp <- read.csv('emp.csv', header = T)
csvtemp; class(csvtemp)
#op
#    no   name pay
# 1 101 홍길동 150
# 2 102 이순신 450
# 3 103 강감찬 500
# 4 104 유관순 350
# 5 105 김유신 400
# [1] "data.frame"


# csv 파일 이용 객체 생성(header=F)
name <- c("사번", "이름", "급여") # 컬럼에 이름 부여
csvtemp2 <- read.csv('emp2.csv',header = F, col.names = name)
csvtemp2
#op -> header에 대한 정보가 없을 시 삽입가능.
#    사번   이름 급여
# 1  101 홍길동  150
# 2  102 이순신  450
# 3  103 강감찬  500
# 4  104 유관순  350
# 5  105 김유신  400


# 데이터프레임 만들기
df <- data.frame(x=c(1:5), y=seq(2,10,2), z=c('a','b','c','d','e'))
df
#op
#   x  y z
# 1 1  2 a
# 2 2  4 b
# 3 3  6 c
# 4 4  8 d
# 5 5 10 e

# 데이터프레임 컬럼명 참조
df$x
#op -> [1] 1 2 3 4 5

# 자료구조, 열수, 행수, 컬럼명 보기
str(df)
#op 
# 'data.frame':	5 obs. of  3 variables:
#   $ x: int  1 2 3 4 5
# $ y: num  2 4 6 8 10
# $ z: chr  "a" "b" "c" "d" ...
ncol(df)
# op -> [1] 3
nrow(df)
# op-> [1] 5
df[c(2:3)]
#op
#    y z
# 1  2 a
# 2  4 b
# 3  6 c
# 4  8 d
# 5 10 e

# 요약 통계량 보기
summary(df)
#op 
#       x           y           z            
# Min.   :1   Min.   : 2   Length:5          
# 1st Qu.:2   1st Qu.: 4   Class :character  
# Median :3   Median : 6   Mode  :character  
# Mean   :3   Mean   : 6                     
# 3rd Qu.:4   3rd Qu.: 8                     
# Max.   :5   Max.   :10      

# 데이터프레임 자료에 함수 적용
apply(df[,c(1,2)], 2, sum)
#op 
#  x  y 
# 15 30 

# 데이터프레임의 부분 객체 만들기
x1 <- subset(df, x >= 3) # x가 3이상인 레코드 대상
x1
#op 
#   x  y z
# 3 3  6 c
# 4 4  8 d
# 5 5 10 e

y1 <- subset(df, y <= 8) # y가 8이하인 레코드 대상
y1
#op
#   x y z
# 1 1 2 a
# 2 2 4 b
# 3 3 6 c
# 4 4 8 d


# 두 개의 조건으로 부분 객체 만들기
xyand <- subset(df, x>=2 & y<=6)
xyand
#op 
#   x y z
# 2 2 4 b
# 3 3 6 c

xyor <- subset(df, x>=2 | y<=6)
xyor
#op
#   x  y z
# 1 1  2 a
# 2 2  4 b
# 3 3  6 c
# 4 4  8 d
# 5 5 10 e


# student 데이터프레임 만들기
sid <- c('A','B','C','D')
score <- c(90, 80, 70, 60)
subject <- c('컴퓨터', '국어국문', '소프트웨어', '유아교육')

student <- data.frame(sid, score, subject)
student
#op 
#    sid score    subject
# 1   A    90     컴퓨터
# 2   B    80   국어국문
# 3   C    70 소프트웨어
# 4   D    60   유아교육

# 자료형과 자료구조 보기
mode(student); class(student) # list, data.frame
str(sid); str(score); str(subject)
#op
# chr [1:4] "A" "B" "C" "D"
# num [1:4] 90 80 70 60
# chr [1:4] "컴퓨터" "국어국문" "소프트웨어" "유아교육"
str(student)
#op
# 'data.frame':	4 obs. of  3 variables:
#   $ sid    : chr  "A" "B" "C" "D"
# $ score  : num  90 80 70 60
# $ subject: chr  "컴퓨터" "국어국문" "소프트웨어" "유아교육"

# 두 개 이상의 데이터프레임 병합하기
height <- data.frame(id=c(1,2), h=c(180, 175))
weight <- data.frame(id=c(1,2), w=c(80,75))
height; weight
# op 
#   id   h
# 1  1 180
# 2  2 175
#   id  w
# 1  1 80
# 2  2 75

person <- merge(height, weight, by.x = "id",by.y = "id")
person
#op 
#    id   h  w
# 1  1 180 80
# 2  2 175 75


# galton 데이터 셋 가져오기
install.packages("UsingR") # 패키지 설치
library(UsingR) # 패키지 메모리에 로드
data("galton") # galton 데이터 셋 가져오기
View(galton)

# galton 데이터 셋 구조 보기
str(galton)
#op
# 'data.frame':	928 obs. of  2 variables:
#   $ child : num  61.7 61.7 61.7 61.7 61.7 62.2 62.2 62.2 62.2 62.2 ...
# $ parent: num  70.5 68.5 65.5 64.5 64 67.5 67.5 67.5 66.5 66.5 ...

dim(galton)
#op -> [1] 928   2

head(galton, 10)
#op
#    child parent
# 1   61.7   70.5
# 2   61.7   68.5
# 3   61.7   65.5
# 4   61.7   64.5
# 5   61.7   64.0
# 6   62.2   67.5
# 7   62.2   67.5
# 8   62.2   67.5
# 9   62.2   66.5
# 10  62.2   66.5

head(galton) # default 갯수:6
#op
#   child parent
# 1  61.7   70.5
# 2  61.7   68.5
# 3  61.7   65.5
# 4  61.7   64.5
# 5  61.7   64.0
# 6  62.2   67.5
tail(galton)
#op 뒤에서 부터 6개
#     child parent
# 923  73.7   70.5
# 924  73.7   69.5
# 925  73.7   69.5
# 926  73.7   69.5
# 927  73.7   69.5
# 928  73.7   69.5

## 6. 문자열 처리

# 문자열 추출하기
install.packages("stringr") # 패키지 설치
library(stringr) # 메모리 로딩

# 형식) str_extract('문자열', '정규표현식')
str_extract("홍길동35이순신45강감찬50","[0-9]{2}")
# op -> [1] "35"
str_extract_all("홍길동35이순신45강감찬50","[0-9]{2}")
# op -> [1] "35" "45" "50"

# 반복수를 지정하여 영문자 추출
string <- 'hongkildong105lee1002you25강감찬2005'
str_extract_all(string, '[a-z]{3}') #3자 연속된 알파벳 추출
#op 
# [[1]]
# [1] "hon" "gki" "ldo" "lee" "you"
str_extract_all(string, '[a-z]{3,}') #3글자 이상 연속된 알파벳 추출
#op  -> [1] "hongkildong" "lee"         "you" 
str_extract_all(string, '[a-z]{3,5}') #3~5글자 연속된 알파벳 추출
# op 
# [[1]]
# [1] "hongk" "ildon" "lee"   "you"  


# 특정 단어 추출
str_extract_all(string, '유관순')
#op
# [[1]]
# character(0)
str_extract_all(string, '강감찬')
#op
# [[1]]
# [1] "강감찬"

# 한글, 영문자, 숫자 추출하기
str_extract_all(string, 'hong')
#op
# [[1]]
# [1] "hong"
str_extract_all(string, '25')
#op
# [[1]]
# [1] "25"
str_extract_all(string, '[가-힣]{3}') # 한글 검색
#op
# [[1]]
# [1] "강감찬"
str_extract_all(string, '[a-z]{3}') # 소문자 검색
#op
# [[1]]
# [1] "hon" "gki" "ldo" "lee" "you"
str_extract_all(string, '[A-Z]{3}') # 대문자 검색
#op
# [[1]]
# character(0)
str_extract_all(string, '[0-9]{4}') # 숫자 검색
#op
# [[1]]
# [1] "1002" "2005"

# 한글, 영문자, 숫자를 제외한 나머지 추출하기
str_extract_all(string, '[^a-z]')
#op
# [[1]]
# [1] "1"  "0"  "5"  "1"  "0"  "0"  "2"  "2"  "5"  "강" "감" "찬" "2"  "0"  "0"  "5" 
str_extract_all(string, '[^a-z]{4}')
#op
# [[1]]
# [1] "1002"   "25강감" "찬200"
str_extract_all(string, '[^가-힣]{5}')
#op
# [[1]]
# [1] "hongk" "ildon" "g105l" "ee100" "2you2"
str_extract_all(string, '[^0-9]{3}')
#op
# [[1]]
# [1] "hon"    "gki"    "ldo"    "lee"    "you"    "강감찬"

# 주민등록번호 검사하기
jumin <- '123456-3234567'
str_extract_all(jumin, '[0-9]{6}-[1234][0-9]{6}')
#op
# [[1]]
# [1] "123456-3234567"
str_extract_all(jumin, '\\d{6}-[1234]\\d{6}') #\d는 숫자라는 의미, \\가 되는 이유는 \를 인식시키기 위해
#op
# [[1]]
# [1] "123456-3234567"

# 지정된 길이의 단어 추출하기
name <- '홍길동1234,이순신5678,강감찬1012'
str_extract_all(name, '\\w{7,}')  #\w : 특수문자만 제외, 
# op 
# [[1]]
# [1] "홍길동1234" "이순신5678" "강감찬1012"
str_extract_all(name, '\\W') #\W : 특수문자만 선택,  
# op
# [[1]]
# [1] "," ","

# 문자열 위치(index) 구하기
string <- 'hongkd105leess1002you25강감찬2005'
str_locate(string, '강감찬')

# 문자열 길이 구하기
string <- 'hongkild105lee1002you25강감찬2005'
len <- str_length(string) # 30
len

# 부분 문자열
string_sub <- str_sub(string, 1, len-7)
string_sub
# op->[1] "hongkild105lee1002you25"
string_sub <- str_sub(string, 1, 23)
string_sub
# op->[1] "hongkild105lee1002you25"

# 대문자, 소문자 변경하기
str_to_upper(string_sub)
# op-> [1] "HONGKILD105LEE1002YOU25"
str_to_lower(string_sub)
# op-> [1] "hongkild105lee1002you25"

# 문자열 교체하기
string_rep <- str_replace(string_sub, 'hongkild105', '홍길동35,')
string_rep <- str_replace(string_rep, 'lee1002', '이순신45,')
string_rep <- str_replace(string_rep, 'you25', '유관순25,')
string_rep
#op -> [1] "홍길동35,이순신45,유관순25,"

# 문자열 결합하기
string_c <- str_c(string_rep, '강감찬55')
string_c
#op ->[1] "홍길동35,이순신45,유관순25,강감찬55"

# 문자열 분리하기
string_sp <- str_split(string_c, ',')
string_sp
#op ->
# [[1]]
# [1] "홍길동35" "이순신45" "유관순25" "강감찬55"

# 문자열 합치기
string_vec <- c('홍길동35', '이순신45', '유관순25', '강감찬55')
string_vec
#op -> [1] "홍길동35" "이순신45" "유관순25" "강감찬55"

string_join <- paste(string_vec, collapse = ',')
string_join
#op -> [1] "홍길동35,이순신45,유관순25,강감찬55"
