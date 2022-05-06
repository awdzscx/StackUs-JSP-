<%@page import="admin.adminDBBean"%>
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
		adminDBBean adb = adminDBBean.getInstance();
		String link = request.getParameter("str");
		adb.changeLink(link);
	%>
		<script type="text/javascript">
			history.back();
		</script>
	<%
	
	%>
</body>
</html>