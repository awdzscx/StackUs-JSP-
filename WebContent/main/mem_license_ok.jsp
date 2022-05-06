<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		String id = session.getAttribute("id").toString();
		String ex_name = request.getParameter("ex_name"); 
		int ex_type = 1;
		MemberDBBean db = MemberDBBean.getInstance();
		int re = db.checkLicense(id, ex_name);
		if(re==1){
				db.addLicense(id, ex_name, ex_type);
	%>
			<script type="text/javascript">
				alert("등록되었습니다.");
				location.href='../main/MyWork.jsp';
			</script>
	<%	
		}else{
	%>
	<script type="text/javascript">
		alert("이미 등록된 자격증입니다.");
		history.back();
	</script>
			
	<%
		}
	%>
	
</body>
</html>