<%@page import="java.net.URLDecoder"%>
<%@page import="exam.examDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	examDBBean db = examDBBean.getInstance();
	String mem_id = request.getParameter("mem_id");
	String ex_object1 = URLDecoder.decode(request.getParameter("ex_object1"),"utf-8"); 
	String ex_object2 = URLDecoder.decode(request.getParameter("ex_object2"),"utf-8"); 
	int ex_code = Integer.parseInt(request.getParameter("ex_code"));
	int ex_sum = db.getEx_sum(ex_object2, ex_code);
	String dab = db.getDab(ex_object2, ex_code);
%>    
<%
	int pagenum = 1;
	if(session.getAttribute("pagenum")!=null){
		pagenum = Integer.parseInt(session.getAttribute("pagenum").toString());
	}
%>
<!DOCTYPE html>
<html>
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
    <script type="text/javascript">
	var inputdab = [<%= ex_sum+1 %>];
	var dab = '<%= dab %>';
	for (var i = 0; i < <%=ex_sum%>; i++) {
		inputdab[i] = 0;
	}
	
	function bo(i,j) {
		console.log(i+"@@@"+j)
		if (inputdab[i] == 0){
			inputdab[i] = j;
			left.document.images['image_'+i+'_'+j].src="../examimg/checked.jpg";
			
		}else if(inputdab[i]==j){
			inputdab[i] = 0;
			left.document.images['image_'+i+'_'+j].src="../examimg/"+j+".jpg";
		}else{
			var k = inputdab[i];
			inputdab[i] = j;
			left.document.images['image_'+i+'_'+k].src="../examimg/"+k+".jpg";
			left.document.images['image_'+i+'_'+j].src="../examimg/checked.jpg";
		}
	}
	function cjclick(){
		var inputdabs = "";
		for (var i = 0; i < inputdab.length; i++) {
			inputdabs += inputdab[i]+"/";
		}
		parent.document.solveForm.inputdabs.value = inputdabs;
		parent.document.solveForm.dab.value = dab;
		parent.document.solveForm.submit();
	}
	
	
	
</script>
</head>
<body style="height : 800px;">
	<center style="height: 700px">
	<iframe name="left" style="width: 70%; height: 60%" src="examSolve.jsp?ex_object1=<%= URLEncoder.encode(ex_object1,"utf-8")%>&ex_object2=<%= URLEncoder.encode(ex_object2,"utf-8")%>&ex_code=<%=ex_code%>"></iframe>
	<br>
	<input type="button" class="btn btn-secondary m-2" onclick="loadbefore(); check(-1);" value="이전">
	<input type="button" class="btn btn-secondary m-2" onclick="loadnext(); check(1);" value="다음">
	<form action="examSolveOk.jsp" method="post" name="solveForm">
		<input type="hidden" name="ex_object1" value="<%= URLEncoder.encode(ex_object1,"utf-8")%>">
		<input type="hidden" name="ex_object2" value="<%= URLEncoder.encode(ex_object2,"utf-8")%>">
		<input type="hidden" name="ex_code" value="<%=ex_code%>">
		<input type="hidden" name="mem_id" value="<%= mem_id %>">
		<input type="hidden" name="inputdabs">
		<input type="hidden" name="dab" value="<%= dab %>">
		<input type="button" class="btn btn-primary m-2" onclick="cjclick()" style="cursor:pointer" value="채점하기">
	</form>
	</center>

	
	<script type="text/javascript">
			var num = 0; 
		function check(i){
			num = num + i;
			console.log(num);
		}	
	
		function loadnext() {
			if (num+1 == <%= ex_sum %>) {
				alert("마지막 문제입니다.")
			}else{
				document.left.solveForm.submit();
			}
		}
		function loadbefore(){
			alert("입력한 답이 초기화 됩니다!");
			inputdab[num] = 0;
			document.left.solvebeforeForm.submit();
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