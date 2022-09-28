# chap01_Basic : 주석문 기호

##############################
#  Chapter01. R 설치와 개요
##############################

# 주요 단축키
# - script 실행 : ctrl+Enter, ctrl+R
# - script 저장 : ctrl+s, ctrl+alt+s(전체파일저장)

# Library 등록.
# - C:/Program Files/R/R-4.1.2/etc/Rprofile.site 파일에 .libPaths("C:/myRLib/Library") 추가 혹은
# - 사용자 변수 새로 만들기 : 변수 이름 -> R_LIBS, 변수 값 : C:\Users\user\Documents\R\win-library\4.1 으로 셋팅.

print("Hello, R!!!") # ctrl+Enter

## 패키지와 Session 보기 

# R package 보기 
dim(available.packages())
#op = [1] 18688    17 dim은 차원의 갯수를 알려주는 매서드로 R에서 제공하는 package의 수를 알려줌.
# R을 잘한다는 의미는 Rd에서 제공하는 패키지를 얼마나 잘 알고 활용하는지로 판단 할 수 있다. 
# 패키지의 목록을 보고 싶다면 다음과 같은 매서드를 실시
available.packages() 

# 패키지 사용법 
install.packages("stringr") # 패키지 설치_ 패키지를 사용하기 위해서는 설치부터 보통 같이 사용되는 패키지들은 같이 다운된다. 
library("stringr") #메모리에 로딩 : "" 생략 가능!
search() # 패키지 메모리 로딩을 확인 
########op###########
# [1] ".GlobalEnv"        "package:stringr"   "tools:rstudio"     "package:stats"     "package:graphics" 
# [6] "package:grDevices" "package:utils"     "package:datasets"  "package:methods"   "Autoloads"        
# [11] "package:base" 
####################
# 자동입력을 통해 보면 {}안에 utils이니 base니 라는 게 적혀저 있는데 이는 base패키지 안에 원하는 기능이 들어있다는 뜻이다. 그래서 search를 통해보면 R이 알아서 설치를 해주고 있다.

#패키지 제거
remove.packages("stringr")
search()
####op#######
# [1] ".GlobalEnv"        "package:stringr"   "tools:rstudio"     "package:stats"     "package:graphics" 
# [6] "package:grDevices" "package:utils"     "package:datasets"  "package:methods"   "Autoloads"        
# [11] "package:base"
###############
# search를 보면 아직 stringr이 있는데 이는 프로그램을 종류하면 사라져 있다.
# 따라서 기능은 매번 새로 설치부터 해야한다.

# R session보기 
sessionInfo() #현재 설치된 R에 대한 정보를 알려준다. 

# 데이터 셋 보기 
data()

# 기본 데이터 셋으로 히스토그램 그리기(시각화)
# 단계 1 : 빈도수(frequency)를 기준으로 히스토그램 그리기
hist(Nile) 
########op#####
#자료 1
###############
# Error: unexpected symbol in: 는 시각와를 표현할 부분의 키기가 작아서이니 창의 넓혀준다.
