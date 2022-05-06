<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="member" class="member.MemberBean"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<%	
		String MEM_TEL = "";
	
		MemberDBBean mb = MemberDBBean.getInstance();
		String id = session.getAttribute("id").toString();
			
	
		String pw = request.getParameter("MEM_PW");
		
		int re = mb.updateMember(id, pw, request.getParameter("MEM_EMAIL"), request.getParameter("MEM_BIRTH"),MEM_TEL, Integer.parseInt(request.getParameter("MEM_TYPE")), request.getParameter("MEM_CONTENT"));
		
		if(re == 1){
	%>
			<script type="text/javascript">
				alert("변경되었습니다!");
				location.href='../main/MyAccount.jsp';
			</script>
	<%
		}else{
	%>
			<script type="text/javascript">
				alert("비밀번호가 잘못되었습니다!");
				history.back();
			</script>
	<%	
		}
	%>
	
	
	
</body>
</html>