<%@page import="teacher.classDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String CLA_NAME = request.getParameter("CLA_NAME");
	String MEM_PW = request.getParameter("MEM_PW");
	String id = session.getAttribute("id").toString();
	
	classDBBean cla = classDBBean.getInstance();
	int re = cla.checkPW(id, MEM_PW);
	
	if(re == 0){
%>
		<script type="text/javascript">
			alert("비밀번호가 틀립니다");
			history.back();
		</script>
<%
	}else if(re == 1){
		
		cla.deleteClass(CLA_NAME);
%>
		<script type="text/javascript">
			alert("클래스가 삭제되었습니다");
			window.close();	
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
%>