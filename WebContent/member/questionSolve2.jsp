
<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@page import="question.questionBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="question.questionDBBean"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Stack Us</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="../lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="../css/style.css" rel="stylesheet">
</head>    
<body>
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>
	<%
		
		String cla_name = "";
		if(session.getAttribute("cla_name")!= null){
			cla_name = session.getAttribute("cla_name").toString();
		}else{
			cla_name = request.getParameter("cla_name");
		}
		int q_no = 1;
		if(session.getAttribute("q_no")== null){
			q_no = Integer.parseInt(request.getParameter("q_no"));
		}else{
			q_no = Integer.parseInt(session.getAttribute("q_no").toString());
		}
		if(session.getAttribute("answerString")!= null){
			session.setAttribute("answerString", session.getAttribute("answerString"));
		}
		
		if(session.getAttribute("rightString")!= null){
			session.setAttribute("rightString", session.getAttribute("rightString"));
		}
		
		questionDBBean db = questionDBBean.getInstance();
		int right = db.getRight(cla_name, q_no);
		ArrayList<String> fnameList = db.getFname(cla_name);
		String mem_id = request.getParameter("mem_id");
		questionBean bean = db.getQ(cla_name, q_no);
			
	%>
	<center>
		<h1><%= bean.getQ_title() %></h1>
		<div>
			<% 
				int percent = db.getPercent(cla_name, q_no);
			%>
			<%= "정답률 :"+percent %>
		</div>
		<% 
			if(fnameList.get(q_no-1).equals("pass")){
			}else{
		%>
			<iframe src="../images/<%=fnameList.get(q_no-1)%>" frameborder="0" width="600 " height="400"></iframe>
			<hr>
		<%		
			} 
		%>
        <div class="border rounded p-4 pb-0 mb-4">
            <figure>
        <%
        	if(bean.getQ_explain() != null){
        %>		
                <blockquote class="blockquote">
                    <p><%= bean.getQ_explain() %></p>
                </blockquote>
        <%        
        	}else{
        %>
                <blockquote class="blockquote">
                    <p>설명없음</p>
                </blockquote>
        <%		
        	}
        %>    
        <%
        	if(bean.getA1()!=null){
        %>
                <figcaption class="blockquote-footer">
                    <%= bean.getA1() %> 
                </figcaption>
                <figcaption class="blockquote-footer">
                    <%= bean.getA2() %> 
                </figcaption>
                <figcaption class="blockquote-footer">
                    <%= bean.getA3() %> 
                </figcaption>
                <figcaption class="blockquote-footer">
                    <%= bean.getA4() %> 
                </figcaption>
        <%		
        	}
        %>
            </figure>
        </div>
		<div>
			<button class="1 btn btn-outline-secondary m-2" onclick="location.href='questionSolveOk2.jsp?cla_name=<%= URLEncoder.encode(cla_name,"utf-8") %>&answer=1/&q_no=<%= q_no %>&right=<%= right+"/" %>&mem_id=<%=mem_id%>'">1</button>
            &nbsp;&nbsp;&nbsp;&nbsp;
			<button class="2 btn btn-outline-secondary m-2" onclick="location.href='questionSolveOk2.jsp?cla_name=<%= URLEncoder.encode(cla_name,"utf-8") %>&answer=2/&q_no=<%= q_no %>&right=<%= right+"/" %>&mem_id=<%=mem_id%>'">2</button>
            &nbsp;&nbsp;&nbsp;&nbsp;
			<button class="3 btn btn-outline-secondary m-2" onclick="location.href='questionSolveOk2.jsp?cla_name=<%= URLEncoder.encode(cla_name,"utf-8") %>&answer=3/&q_no=<%= q_no %>&right=<%= right+"/" %>&mem_id=<%=mem_id%>'">3</button>
            &nbsp;&nbsp;&nbsp;&nbsp;
			<button class="4 btn btn-outline-secondary m-2" onclick="location.href='questionSolveOk2.jsp?cla_name=<%= URLEncoder.encode(cla_name,"utf-8") %>&answer=4/&q_no=<%= q_no %>&right=<%= right+"/" %>&mem_id=<%=mem_id%>'">4</button>
            &nbsp;&nbsp;&nbsp;&nbsp;
			<button class="4 btn btn-outline-secondary m-2" onclick="location.href='questionSolveOk2.jsp?cla_name=<%= URLEncoder.encode(cla_name,"utf-8") %>&answer=5/&q_no=<%= q_no %>&right=<%= right+"/" %>&mem_id=<%=mem_id%>'">5</button>
		</div>
	</center>
	    <!-- Form End -->
    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../lib/chart/chart.min.js"></script>
    <script src="../lib/easing/easing.min.js"></script>
    <script src="../lib/waypoints/waypoints.min.js"></script>
    <script src="../lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="../lib/tempusdominus/js/moment.min.js"></script>
    <script src="../lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="../lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="../js/main.js"></script>
</body>
</html>