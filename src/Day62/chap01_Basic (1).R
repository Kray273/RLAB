# chap01_Basic : 주석문 기호

##############################
#  Chapter01. R 설치와 개요
##############################

# 주요 단축키
# - script 실행 : ctrl+Enter, ctrl+R
# - script 저장 : ctrl+s(현재 파일), ctrl+alt+s(전체파일저장)

print("Hello, R!!!") # ctrl+Enter

## 패키지와 Session 보기

# R package 보기
dim(available.packages()) # 18688    17
available.packages() # R 패키지 목록 보기

# 패키지 사용법
install.packages("stringr") # 패키지 설치

# 설치된 패키지 확인
installed.packages()

library("stringr") # 메모리에 로딩 : "" 생략 가능
search() # 패키지 메모리 로딩 확인

# 패키지 제거
remove.packages("stringr")

# R session 보기
sessionInfo()

# 데이터 셋 보기
data()

# 기본 데이터 셋으로 히스토그램 그리기(시각화)
# 단계1 : 빈도수(frequency)를 기준으로 히스토그램 그리기
hist(Nile)
# op : 사진 1 
# Error: unexpected symbol in: 는 시각와를 표현할 부분의 키기가 작아서이니 창의 넓혀준다.

#단계 2 : 밀도(density)를 기준으로 히스토그램 그리기
hist(Nile, freq = F)
# op : 사진 2
# 자바의 오버로딩과 같은 개념으로 같은 매서드여도 변수의 개수가 달라 사용할 수 있다.
# 엄밀히 말하면 작동원리는 오버로딩의 개념이 아니다. 
# F = FALSE 인데 R은 대소문자를 구분하고, 부울린의 값은 대문자만 정의됨. 약자를 지원함(TRUE = T). 
# 자바와 달리 변수의 순서가 달라져도 상관없다.
# 그 이유는 
?hist
# 함수에 대한 정보를 보기 사진 3.
# R은 데이터 타입(자료형)이 없다. 따라서 매개변수 선언시 변수 이름만 작성하면 된다. 
# R에서 매개변수를 선언하면서 디폴트값이 정의되어 있다. 그래서 매개변수를 전달하지 않으면 디폴트값이 지정
# 즉. 매개변수를 정의하게 된다면 값을 받아와 전달하게 된다.(순서가 필요없다)
# 또한 정해진 디폴트 값은 알고 있다면 매개변수를 적지 않고 값만 넣어도 된다.
# FALSE로 했는데 density가 나오는 이유는 Freq가 F가 되서 다음으로 오는 density가 Y축이 됨. 

#단계 3 : 단계2의 결과에 분포곡선(line)을 추가. 
lines(density(Nile))
#op -> 사진 4. 

# 히스토그램 파일에 저장하기.
par(mfrow = c(1, 1)) # plots 영역에 1개의 그래프 표시
# c라는 함수는 combine의 약자로 첫번째와 두번째 지정된 매개변수에 1을 전달한다. 
# mflow에 c가 리턴한 값을 받아 전달 받는다. 
# par은 히스토그램을 출력해달라는 의미이다. 
pdf("C:/workspaces/RLAB/src/Day62/output/batch.pdf") # /가 폴더 변경
hist(rnorm(20)) #정규분포를 따르는 랜덤한 값 20개 발생
dev.off()
# op -> 사진 5.














## 4. 변수와 자료형
# 변수 사용 예
age <- 25
age
age <- 35
age

# 변수.멤버  형태로 변수 선언 예


var1 <- 50
var2 <- 100

# 스칼라 변수 사용 예
name <- "홍길동"
name

# 자료형
int <- 20    # 숫자형(정수)
double <- 3.14 # 숫자형(실수)
string <- "홍길동"  # 문자형
boolean <- TRUE  # 진리값 : TRUE(T) / FALSE(F)
boolean

boolean <- 3.14
boolean

# 자료형 확인




# 문자 원소를 숫자 원소로 형변환
x <- c(1, 2, 3)
x

# 숫자 원소를 문자 원소로 형변환
y <- c(1, 2, "3")
y

result <- x * 3
result


result <- y * 5 

result <- as.integer(y) * 5
result


# 복소수형 자료 생성과 형변환
z <- 5.3 - 3i
Re(z)
Im(z)
is.complex(z) # TRUE
as.complex(5.3) # 5.3+0i

# 스칼라 변수의 자료형
mode(int)
mode(string)
mode(boolean)

# 문자 벡터와 그래프 생성
gender <- c('man', 'woman', 'woman', 'man', 'man')
gender

mode(gender)
class(gender)

plot(gender)

# 요인형 변환
# as.factor() 함수 이용 범주(요인)형 변환
Ngender <- as.factor(gender)
Ngender
table(Ngender)

# Factor형 변수로 차트 그리기
plot(Ngender)
mode(Ngender)
class(Ngender)
is.factor(Ngender)

# Factor Nominal 변수
Ngender

# factor() 함수 이용 Factor형 변환



# 순서 없는 요인과 순서 있는 요인형 변수로 차트 그리기



# 도움말 보기
i <- sum(1, 2, 3)
i

help(sum)
?sum

# 함수 파라메터 보기
args(sum)

# 함수 사용 예제 보기
example(sum)

# 작업 공간 지정

