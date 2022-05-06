<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		session.setAttribute("ex_name", null);
		session.setAttribute("ex_year", null);
		session.setAttribute("ex_type", null);
		session.setAttribute("ex_no", null);
		session.setAttribute("answerString", null);
		session.setAttribute("rightArray", null);
		session.setAttribute("examNum", null);
	%>
	<script type="text/javascript">
		window.close();
	</script>
</body>
</html>