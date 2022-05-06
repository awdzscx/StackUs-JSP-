<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="board" class="board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%
	
	int bo_no = Integer.parseInt(request.getParameter("bo_no"));
	
	
	BoardDBBean db = BoardDBBean.getInstance();
	db.editBoard(board);
%>
<script type="text/javascript">
	location.href='../board/show.jsp?bo_no=<%= bo_no %>&pageNum=1';
</script>