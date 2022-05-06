<%@page import="java.net.URLEncoder"%>
<%@page import="youtube.youtube"%>
<%@page import="teacher.classDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%	
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		String str = request.getParameter("str");
		str = request.getParameter("str");
		
		youtube you = new youtube();
		String re = you.youtubeLink(str);
		
		String cla_name = request.getParameter("cla_name");
		
		classDBBean db = classDBBean.getInstance();
		db.setLink(cla_name, re);
		String tea_id = db.getTeaId(cla_name);
		
		response.sendRedirect("../member/classMain.jsp?cla_name="+URLEncoder.encode(cla_name,"utf-8")+"&tea_id="+tea_id);
	
	%>
</body>
</html>