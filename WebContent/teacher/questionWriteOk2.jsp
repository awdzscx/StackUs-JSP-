<%@page import="java.net.URLDecoder"%>
<%@page import="question.questionDBBean"%>
<%@page import="question.questionBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); 
response.setCharacterEncoding("utf-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String q_fname=URLDecoder.decode(request.getParameter("q_fname"),"utf-8");
		if(q_fname.equals("null")){
			q_fname="pass";
		}
		questionBean bean = new questionBean();
		
		bean.setCla_name(request.getParameter("cla_name"));
		bean.setQ_fname(q_fname);
		bean.setQ_right(Integer.parseInt(request.getParameter("q_right")));
		bean.setSubject_subject_name(request.getParameter("subject_subject_name"));
		bean.setQ_answer(request.getParameter("q_answer"));
		bean.setQ_title(request.getParameter("q_title"));
		bean.setQ_explain(request.getParameter("q_explain"));
		bean.setA1(request.getParameter("a1"));
		bean.setA2(request.getParameter("a2"));
		bean.setA3(request.getParameter("a3"));
		bean.setA4(request.getParameter("a4"));
		
		questionDBBean db = questionDBBean.getInstance();
		int re = db.insertQuestion(bean);
		
		if(re == 1){
	%>
		<script type="text/javascript">
			var keep = confirm("계속 입력하시겠습니까?");
			if (keep == true) {
				location.href="questionWrite.jsp?cla_name=<%=request.getParameter("cla_name") %>";				
			}else{
				window.close();
			}
		</script>		
	<% 
		}else{
	%>
		<script type="text/javascript">
			alert("입력이 실패했습니다.");
			history.back();
		</script>		
	<%
		}
		
	%>
	<%= request.getParameter("cla_name") %>
	<%= request.getParameter("q_fname") %>
	<%= request.getParameter("q_right") %>
</body>
</html>