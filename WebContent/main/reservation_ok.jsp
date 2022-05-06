<%@page import="reservation.resDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	String id = session.getAttribute("id").toString();

	resDBBean db = resDBBean.getInstance();
	int re = db.makeRes(id, request.getParameter("res_date").toString(), request.getParameter("ex_name"));
	
	if(re == 1){
%>
		<script type="text/javascript">
			alert("예약되었습니다");
			history.back();
		</script>
<%
	}else if(re == 0){
%>
		<script type="text/javascript">
			alert("이미 등록된 시험입니다");
			history.back();
		</script>
<%		
	}else{
%>
		<script type="text/javascript">
			alert("등록을 실패했습니다");
			history.back();
		</script>
<%		
	}
%>
