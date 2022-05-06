<%@page import="teacher.classDBBean"%>
<%@page import="teacher.classBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="cla" class="teacher.classBean"></jsp:useBean>
<jsp:setProperty name="cla" property="*"/>
<%
	String id = session.getAttribute("id").toString();
	String CLA_NAME = request.getParameter("CLA_NAME");
	String CLA_INTRO =request.getParameter("CLA_INTRO");
	String SUBJECT_SUBJECT_NAME = request.getParameter("SUBJECT_SUBJECT_NAME");
	
	classDBBean db = classDBBean.getInstance();
	int re = db.insertClass(id, CLA_NAME, CLA_INTRO, SUBJECT_SUBJECT_NAME);
	
	
	 if(re == 1){ 
%>
		<script type="text/javascript">
			alert("클래스가 생성되었습니다!");
			window.close();
		</script>
<%		
	}else if(re == 0){
%>
		<script type="text/javascript">
			alert("같은 클래스명이 있습니다");
			history.back();
		</script>
<%			
	}else{
%>
		<script type="text/javascript">
			alert("클래스 생성에 실패했습니다");
			history.back();
		</script>
<%			
	}
%>


