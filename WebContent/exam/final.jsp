<%@page import="java.net.URLDecoder"%>
<%@page import="exam.examDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
    <meta charset="utf-8">
    <title>Stack Us</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="../img/favicon.ico" rel="icon">

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
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

	function cjclick() {
		console.log(inputdab);
		console.log(dab);
	}
	
</script>
</head>
<body style="height : 800px;">
	<%
		String mem_id = request.getParameter("mem_id");
		String ex_object1 = URLDecoder.decode(request.getParameter("ex_object1"),"utf-8"); 
		String ex_object2 = URLDecoder.decode(request.getParameter("ex_object2"),"utf-8"); 
		int ex_code = Integer.parseInt(request.getParameter("ex_code"));
		examDBBean db = examDBBean.getInstance();
		int eq = db.exsum(ex_object1, ex_object2, ex_code);
		int req = (eq/6)+1;
		String dab = db.getDab(ex_object2, ex_code);
	%>
	<iframe name="left" style="width: 70%; height: 100%" src="solve.jsp?ex_object1=<%= URLEncoder.encode(ex_object1,"utf-8")%>&ex_object2=<%= URLEncoder.encode(ex_object2,"utf-8")%>&ex_code=<%=ex_code%>&pagenum=<%=1%>"></iframe>
	<iframe name="right" style="width: 108px; height: 100%" src="omr.jsp?ex_object1=<%= URLEncoder.encode(ex_object1,"utf-8")%>&ex_object2=<%= URLEncoder.encode(ex_object2,"utf-8")%>&ex_code=<%=ex_code%>&pagenum=<%=1%>"></iframe>
	<br>
	
	<div style="width: 70%" align="center">
		<input type="button" onclick="loadpre()" value="이전">&nbsp;&nbsp;
		<input type="button" onclick="loadnext()" value="다음">&nbsp;&nbsp;
		<hr>
		<form action="examSolveOk.jsp" method="post" name="solveForm">
			<input type="button" onclick="right.cjclick()" style="cursor:pointer" value="채점하기">
			<input type="hidden" name="ex_object1" value="<%= URLEncoder.encode(ex_object1,"utf-8")%>">
			<input type="hidden" name="ex_object2" value="<%= URLEncoder.encode(ex_object2,"utf-8")%>">
			<input type="hidden" name="ex_code" value="<%=ex_code%>">
			<input type="hidden" name="mem_id" value="<%= mem_id %>">
			<input type="hidden" name="inputdabs">
			<input type="hidden" name="dab">
			<input type="hidden" name="type" value="omr">
		</form>
	</div>
	
	<script type="text/javascript">
		var pg = 1;
		var req = <%=req%>;
		
		function loadnext() {
			pg++;
			if (pg > req) {
				pg--;
			}
			left.location.href='solve.jsp?ex_object1=<%= URLEncoder.encode(ex_object1,"utf-8")%>&ex_object2=<%= URLEncoder.encode(ex_object2,"utf-8")%>&ex_code=<%=ex_code%>&pagenum='+pg;
		}
		function loadpre() {
			pg--;
			if (pg < 1) {
				pg++;
			}
			left.location.href='solve.jsp?ex_object1=<%= URLEncoder.encode(ex_object1,"utf-8")%>&ex_object2=<%= URLEncoder.encode(ex_object2,"utf-8")%>&ex_code=<%=ex_code%>&pagenum='+pg;
		}
	</script>
	
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