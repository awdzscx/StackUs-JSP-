<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String id = request.getParameter("id");
	String cla_name = request.getParameter("cla_name");
	MemberDBBean db = MemberDBBean.getInstance();
	int re = db.exitClass(id, cla_name);
	
	if(re == 1){
		%>
		<script type="text/javascript">
			alert("강퇴되었습니다");
			window.close();
		</script>
		<%
	}
%>
