<%@page import="java.sql.Timestamp"%>
<%@page import="comment.CommentDBBean"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="comment" class="comment.CommentBean"></jsp:useBean>
<jsp:setProperty property="*" name="comment"/>
<%
	comment.setCo_date(new Timestamp(System.currentTimeMillis())); 
	CommentDBBean cm = CommentDBBean.getInstance(); // getInstance 메소드만 static메소드라서 뜬다.
	int re = cm.insertComment(comment);
	
	
	if(re == 1){ // insertBoard의 re가 성공이면
		response.sendRedirect("../board/show.jsp?bo_no="+comment.getBo_no());
	}else{
		response.sendRedirect("../board/show.jsp?bo_no="+comment.getBo_no());
	}
%>