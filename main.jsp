<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<link rel="stylesheet" href="index.css" type="text/css">
</head>
<body>
	<div style="width:1250px"  align="center">
    <header>
        <h1>
            <a href="main.html">Stack Us</a>
        </h1>
        <p>
            <h4><img src="../images/a.gif" width="20">&nbsp;<input type="text"></h4> <br>
        </p>
    </header>
    <nav class="dropmenu">
        <ul>
            <li><a href="main.jsp">홈</a></li>
            <li><a href="main.jsp">문제풀기</a></li>    <!-- 경로 변경 예정-->
            <li><a href="main.jsp">선생님</a></li>
            <li><a href="main.jsp">학 생</a></li>
            <li><a href="main.jsp">커뮤니티</a></li>   <!-- 메뉴 드롭형식으로 --> 
        </ul>
    </nav>
    <section id="main">
        <article>
            <iframe src="#" frameborder="1" width="1000" height="420"></iframe>
        </article>
        <article>
            <iframe frameborder="1" width="1000" height="300"></iframe>
        </article>
    </section>
    </section>
    <aside id="right">
        <div id="login">
        <br>
            <h3>로그인</h3>
                <form action="#" method="POST">
                                              아이디
                    <input type="text"><br>
                                             패스워드
                    <input type="password"><br>
                    <input type="submit" value="로그인" onclick="#">
                    <input type="button" value="회원가입" onclick="javascript:window.location='signup.jsp'"><br>
                    <a href="#">아이디 찾기</a><br>
                    <a href="#">비밀번호 찾기</a>
                </form>
        </div>
    </aside>
    <footer>
        <img src="../images/b.gif"" width="100">
        <h2>&nbsp;고객센터 1544-9999</h2><br>
        &nbsp;&nbsp;평일(월~금) 09:00 - 18:00<br>
        &nbsp;&nbsp;토요일/일요일/공휴일 휴무
    </footer>
    </div>
</body>
</html>