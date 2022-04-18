<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<link rel="stylesheet" href="signup.css" type="text/css">
</head>
<body>
	<div style="width:700px"  align="center">
		<header>
	        <h1>
	            <a href="page.html">Stack Us</a><br>
	        </h1>
	    </header>
	    <hr><hr>
	    <div class="wrapper">
	        <div class="title"><h1 style="font-size: 21px;">회원가입</h1></div><br>
	        <div class="email">
	            <input id="email" type="text" placeholder="이메일을 입력해 주세요.">
	            <div id="emailError" class="error"></div>
	        </div>
	        <div class="name">
	            <input id="name"  type="text" placeholder="이름을 입력해 주세요.">
	            <div id="nameError" class="error"></div>
	        </div>
	        <div class="password">
	            <input id="password" type="password" placeholder="비밀번호를 입력해 주세요.">
	            <div id="passwordError" class="error"></div>
	        </div>
	        <div class="passwordCheck">
	            <input id="passwordCheck" type="password" placeholder="비밀번호를 다시 입력해 주세요.">
	            <div id="passwordCheckError" class="error"></div>
	        </div>
	        <div class="phone"> 
	            <!--input id="phone1" type="text" size="1" maxlength="3" oninput="changePhone1()"-->
	            <select id="phone1">
	            	<option>010</option>
	            	<option>011</option>
	            	<option>016</option>
	            	<option>019</option>
	            </select>
	             -
	            <input id="phone2" type="text" size="3" maxlength="4" oninput="changePhone2()"> -
	            <input id="phone3" type="text" size="3" maxlength="4" oninput="changePhone3()">
	        </div>
	        <br>
	        <div class="area">
	            <select id="area">
	                <option selected disabled>지역을 선택하세요.</option>
	                <option>서울특별시</option>
	                <option>경기도</option>
	                <option>인천광역시</option>
	                <option>부산광역시</option>
	                <option>대전광역시</option>
	                <option>대구광역시</option>
	                <option>광주광역시</option>
	                <option>경상북도</option>
	                <option>경상남도</option>
	                <option>전라북도</option>
	                <option>전라남도</option>
	                <option>충청북도</option>
	                <option>충청남도</option>
	            </select>
	            <div id="areaError" class="error"></div>
	        </div>
	        <div class="gender">
	            <input id="gender_man" type="radio" name="gender"> 남성 &nbsp;  
	            <input id="gender_woman" type="radio" name="gender"> 여성
	            <div id="genderError" class="error"></div>
	        </div>
	        <div class="line">
	            <hr>
	        </div>
	        <div class="signUp">
	            <button id="signUpButton" disabled onclick="signUpCheck()">가입하기</button>
	        </div>
	    </div>
    </div>
</body>
</html>