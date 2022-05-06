<%@page import="java.net.URLEncoder"%>
<%@page import="question.questionDBBean"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="teacher.classDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
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

	<% String answerString = session.getAttribute("answerString").toString(); %>
	<% String rightString = session.getAttribute("rightString").toString(); %>
	<%
		String cla_name = session.getAttribute("cla_name").toString();
		
		StringTokenizer st = new StringTokenizer(answerString,"/");
		ArrayList<String> answerList = new ArrayList<String>();
 		while(st.hasMoreTokens()){
			answerList.add(st.nextToken());
		}
 		
 		StringTokenizer st2 = new StringTokenizer(rightString,"/");
 		ArrayList<String> rightList = new ArrayList<String>();
 		while(st2.hasMoreTokens()){
 			rightList.add(st2.nextToken());
 		}
 		
 		questionDBBean db = questionDBBean.getInstance();
 		String incorrectString = "";
 		
 		int correct = 0;
 		int incorrect = 0;
 		for(int i = 0; i < answerList.size(); i++){
	 		if(answerList.get(i).equals(rightList.get(i))){
	 			correct++;
	 			db.upCorrect(cla_name, i+1);
	 		}else{
	 			incorrect++;
	 			db.upIncorrect(cla_name, i+1);
				incorrectString += (i+1)+"/";
	 		}
 		}
 		
 		String mem_id = request.getParameter("mem_id");
 		classDBBean cdb = classDBBean.getInstance();
 		cdb.upPoint(cla_name, mem_id);
	%>
			    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-xl-6">
	
	<p>맞힌 문제 : <%= correct %>개</p>
	<p>틀린 문제 : <%= incorrect %>개</p>
	<%= cla_name %>
	<br><br>
	<hr>
	<button class="btn btn-outline-primary m-2" onclick="location.href='questionWrong.jsp?cla_name=<%= URLEncoder.encode(cla_name,"utf-8")%>&incorrectString=<%=incorrectString%>'">틀린문제 보러가기</button>
	<button class="btn btn-outline-primary m-2" onclick="window.close()">종료하기</button>
	
			</div>
		</div>
		</div>
	
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