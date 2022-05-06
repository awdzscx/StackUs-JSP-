<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
	String id = session.getAttribute("id").toString();
	String pw = request.getParameter("mem_pw");
	
	MemberDBBean db = MemberDBBean.getInstance();
	
	int re = db.pwCheck(id, pw);
	
	if(re == 0){
%>
	<script type="text/javascript">
		alert("비밀번호가 일치하지 않습니다");
		history.back();
	</script>
<%
	}else if(re == 1){
		int rs = db.deleteMember(id);
		
			if(rs == 1){
				session.invalidate();
%>
				<script type="text/javascript">
					alert("삭제에 성공했습니다");
					location.href='main.jsp';
				</script>
<%
			}else{
%>
				<script type="text/javascript">
					alert("삭제에 실패했습니다");
					history.back();
				</script>
<%	
			}
		
	}else{
%>
		<script type="text/javascript">
			alert("삭제에 실패했습니다");
			history.back();
		</script>
<%		
	}
%>