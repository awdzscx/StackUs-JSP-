<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String id = session.getAttribute("id").toString();
	String CLA_NAME=request.getParameter("cla_name");
	MemberDBBean db = MemberDBBean.getInstance();
	int re = db.exitClass(id, CLA_NAME);
	
	if(re == 1){
		%>
		<script type="text/javascript">
			alert("탈퇴되었습니다.");
			location.href='../member/mem_Main.jsp';
		</script>
		<%
	}else if(re == 0){
		%>
		<script type="text/javascript">
			alert("클래스에 소속된 회원이 아닙니다.");
			history.back();
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("탈퇴할 수 없습니다.");
			history.back();
		</script>
		<%
	}
%>