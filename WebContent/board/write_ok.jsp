<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%
	board.setBo_date(new Timestamp(System.currentTimeMillis())); 
	BoardDBBean db = BoardDBBean.getInstance(); // getInstance 메소드만 static메소드라서 뜬다.
	int re = db.insertBoard(board);
	
	
	
	 if(re == 1){ // insertBoard의 re가 성공이면
		response.sendRedirect("../board/boardlist_"+board.getBo_type()+".jsp");
	}else{
%>
		<script>
			alert("입력실패했습니다.");
			history.back();
		</script>
<%		
	} 
%>
