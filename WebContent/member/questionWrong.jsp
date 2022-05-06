<%@page import="question.questionBean"%>
<%@page import="question.questionDBBean"%>
<%@page import="exam.examDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.StringTokenizer"%>
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
    <script type="text/javascript" src="../js/exam2.js"></script>
</head>
<body>
	
	<% 
		String cla_name = request.getParameter("cla_name");
		String incorrectString = request.getParameter("incorrectString");
		StringTokenizer st = new StringTokenizer(incorrectString,"/");
		ArrayList<String> incorrectList = new ArrayList<String>();
		ArrayList<String> fnameList = new ArrayList<String>();
		
		while(st.hasMoreTokens()){
			incorrectList.add(st.nextToken());
		}
		questionDBBean db = questionDBBean.getInstance();
		fnameList = db.getFname(cla_name);
		String fname = "";
	%>

	
	<!--  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	
	    <!-- Form Start -->
			<table class="table table-hover">
			<tr>
				<td class="text-center" width="10%">번호</td>
				<td class="text-center" width="30%">문제</td>
				<td class="text-center" width="20%">해설</td>
				<td class="text-center" width="10%">정답</td>
				<td class="text-center" width="10%">정답률</td>
			</tr>
	<%	
		for(int i = 0; i < incorrectList.size(); i++){
			fname = fnameList.get(Integer.parseInt(incorrectList.get(i))-1);
			int right = db.getRight(cla_name, Integer.parseInt(incorrectList.get(i)));
			questionBean bean = db.getQ(cla_name, i+1);
	%>
			<tr>
				<td class="text-center"><%= incorrectList.get(i)  %></td>
	<%
		if(fname.equals("pass")){
	%>
				<td class="text-center"><%= bean.getQ_title() %></td>
	<%		
		}else{
	%>
				<td class="text-center"><img src="../images/<%= fname %>" width="100%" height="50%"></td>
	<%		
		}
	%>			
				<td class="text-center"><%= db.getAnswer(cla_name,Integer.parseInt(incorrectList.get(i))) %></td>
				<td class="text-center"><%= right %></td>
				<td class="text-center"><%= db.getPercent(cla_name, Integer.parseInt(incorrectList.get(i))) %>%</td>
			</tr>
	<%		
		}
	%>
		</table>
			<br>
		<div class="text-center">
			<button class="btn btn-primary m-2" onclick="window.close()">종료하기</button>
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