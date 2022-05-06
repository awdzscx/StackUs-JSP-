<%@page import="nl.captcha.Captcha"%>
<%@page import="member.MemberBean"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="member" class="member.MemberBean" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%	


	if(session.getAttribute("cr") != null){
		MemberDBBean mb = new MemberDBBean();
		int result = mb.insertMember(member);
		
		if(result == -1){
			PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('이미 존재하는 아이디입니다.')");
	        script.println("history.back()");
	        script.println("</script>");
		}else{
			session.setAttribute("MEM_ID", member.getMEM_ID());
			PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('회원가입 성공.')");
	        script.println("location.href='../main/main.jsp'");
	        script.println("</script>");
		}
		session.removeAttribute("cr");
	} else {
		PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('자동입력 방지문자를 입력해주세요.')");
        script.println("history.back()");
        script.println("</script>");
	}
	
%>