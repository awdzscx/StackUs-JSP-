<%@page import="java.net.URLEncoder"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
	 String path = request.getRealPath("images"); 
	 int maxSize = 1024*1024*10;
	 int fileSize = 0;
	 String file = "pass";
	 String orifile= "";
	 
	 if(!file.equals(request.getParameter("q_fname"))){
		 
			 MultipartRequest multi = new MultipartRequest(request,path,maxSize,"utf-8",new DefaultFileRenamePolicy());
			 Enumeration files = multi.getFileNames();
			 String str = (String)files.nextElement();
			 file = multi.getFilesystemName(str);
			 
			 if(file != null){
				 orifile = multi.getOriginalFileName(str);
				 fileSize = file.getBytes().length;
			 }
			 
	 }else{
	 }
			 					 
	 String mem_id = session.getAttribute("mem_id").toString();
	 String cla_name = session.getAttribute("cla_name").toString();
	 session.setAttribute("mem_id", mem_id);
	 session.setAttribute("cla_name", cla_name);
	
	%>
	<%  response.sendRedirect("questionWrite2.jsp?q_fname="+URLEncoder.encode(file,"utf-8"));%>
</body>
</html>