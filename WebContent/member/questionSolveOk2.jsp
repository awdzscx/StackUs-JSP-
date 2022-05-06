<%@page import="question.questionDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<% 
		int q_no = Integer.parseInt(request.getParameter("q_no"));
		String cla_name = request.getParameter("cla_name");
		q_no++;
		questionDBBean db = questionDBBean.getInstance();
		int count_q_no = db.getQ_no(cla_name);
		
		String rightString = "";
		if(session.getAttribute("rightString")!=null){
			rightString = session.getAttribute("rightString").toString();
		}
		String right = request.getParameter("right");
		rightString += right;
		
		String answerString = "";
		if(session.getAttribute("answerString")!= null){
			answerString = session.getAttribute("answerString").toString();
		}
		String mem_id = request.getParameter("mem_id");
				
		String answer = request.getParameter("answer");
		answerString += answer;
		
		if(q_no > count_q_no){
			session.setAttribute("cla_name", cla_name);
			session.setAttribute("q_no", q_no-1);
			session.setAttribute("answerString", answerString);
			session.setAttribute("rightString", rightString);
			response.sendRedirect("questionResult.jsp?mem_id="+mem_id);
		}else{
			session.setAttribute("q_no", q_no);
			session.setAttribute("answerString", answerString);
			session.setAttribute("rightString", rightString);
			response.sendRedirect("questionSolve2.jsp?mem_id="+mem_id);
		}
	%>
</body>
</html>