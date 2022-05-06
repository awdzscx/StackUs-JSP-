<%@page import="java.net.URLEncoder"%>
<%@page import="teacher.classBean"%>
<%@page import="teacher.classDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("utf-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		String cla_name = request.getParameter("cla_name");
		String mem_id = request.getParameter("mem_id");
		String tea_id = request.getParameter("tea_id");
	%>
	<%  
		classDBBean db = classDBBean.getInstance();
		int re = db.checkMem(cla_name, mem_id);
		if(re == 1){
			%>
				<script type="text/javascript">
					alert("이미 가입했습니다.");
					history.back();
				</script>
			
			<%		
				}else{
					classBean bean = db.getClass(tea_id, cla_name);
					int re2 =db.insertMem(cla_name, bean.getCla_intro(), bean.getSubject_subject_name(), mem_id);
					if(re2 == 1){
			%>
				<script type="text/javascript">
					alert("가입성공!");
					window.close();
				</script>	
			<%			
					}else{
			%>
				<script type="text/javascript">
					alert("가입성공!");
					window.close();
				</script>	
			<%			
					}
				}
			 %>
</body>
</html>