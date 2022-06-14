###### StackUs

### StackUs 란? 
---
+ 온라인 상에서 교사와 학생들 간에 소통과 학습을 동시에 할 수 있는 플랫폼입니다.

### 사용자
---
+ 학교에서 직접 학생들을 가르치는 교사부터 과외를 통해 몇명의 학생을 가르치는 소규모 교사들도 쉽게 문제를
 내고, 학생관리와 피드백을 할 수 있는 플랫폼 입니다.

### 적용방법
---
+ ZIP파일과 SQL파일을 다운로드후, ECLIPSE를 통해서 ZIP파일을 임포트
+ CMD창에서 STACKUS/ 1234계정을 생성하고 DBA에 권한을 준 다음, SQL파일을 임포트
+ C\PROGRAM FILES\ JAVA \ JRE1.8.0_311\LIB\SECURITY\JAVA.SECURITY 파일에서 TLSv1, TLSv1.1 삭제
+ SERVER.XML에서 리소스 입력 (PPT 참고)
+ MAIN.JSP파일을 통해서 메인페이지에서 실행 

### 개발기간
---
+ 2022년 4월 22일 ~ 2022년 5월 6일

### 기술스택
---
+ Front
  + CSS
  + HTML
  + JAVA SCRIPT
  + JQUERY
  + BOOTSTRAP
+ Back
  + JAVA
  + JSP
  + ORACLE DB
+ ETC
  + GIT HUB
  + TOMCAT
  + NAVER MAIL
### 기획 및 설계
---
+ 프로젝트 기획, 개발 환경 구축
+ 데이터 베이스 설계도 ![설계도](https://github.com/ParkSolchan/StackUs/blob/main/STACKUS%20ERD.png)

    
### 본인이 구현한 기능들
+ 게시판 글쓰기, 수정, 삭제
+ 게시판 구별
+ 댓글 구현(대댓글)
+ 댓글 삭제
+ 추천 기능
+ 게시판 검색 기능
+ 게시판 관리자 구별
+ OMR구현
+ 실시간 채팅방 구현
+ 캡챠 api 활용한 자동입력방지 구현
