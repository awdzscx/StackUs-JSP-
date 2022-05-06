<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	 String path = request.getRealPath("images"); 
	 int maxSize = 1024*1024*10;
	 int fileSize = 0;
	 String file = "";
	 String orifile= "";
	 
	 
	 
	 MultipartRequest multi = new MultipartRequest(request,path,maxSize,"utf-8",new DefaultFileRenamePolicy());
	 Enumeration files = multi.getFileNames();
	 String str = (String)files.nextElement();
	 file = multi.getFilesystemName(str);
	 
	 if(file != null){
		 orifile = multi.getOriginalFileName(str);
		 fileSize = file.getBytes().length;
	 }
	 
	 String ex_fname = request.getParameter("ex_fname");
	 session.setAttribute("ex_fname", file);
	 response.sendRedirect("../exam/examWrite2.jsp");
	%>
</body>
</html>