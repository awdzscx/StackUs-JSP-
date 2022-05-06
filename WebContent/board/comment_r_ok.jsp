<%@page import="comment.CommentDBBean"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="comment" class="comment.CommentBean"></jsp:useBean>
<%
	int count = Integer.parseInt(request.getParameter("co_nom"));
	int bo_no = Integer.parseInt(request.getParameter("bo_no"));
	response.sendRedirect("show.jsp?bo_no="+bo_no+"&count="+count);
%>
