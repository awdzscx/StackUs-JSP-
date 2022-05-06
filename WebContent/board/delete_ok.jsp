<%@page import="java.io.File"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%

	int bo_no = Integer.parseInt(request.getParameter("bo_no"));
	
	BoardDBBean db = BoardDBBean.getInstance();
	BoardBean board = db.getBoard(bo_no, false);
	
	int bty=board.getBo_type();
	int re = db.deleteBoard(bo_no);
	
	if(re == 1){
		if(bty == 1) response.sendRedirect("../board/boardlist_"+board.getBo_type()+".jsp");
	}else if(re == 0){
		//비밀번호 틀림
%>
		<script>
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>
<%
	}else if(re == -1){
		//삭제 실패
%>
		<script>
			alert("삭제에 실패하였습니다..");
			history.go(-1);
		</script>
<%
	}
%>