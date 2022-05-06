<%@page import="exam.examDBBean"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ex_object1 = URLDecoder.decode(request.getParameter("ex_object1"),"utf-8"); 
	String ex_object2 = URLDecoder.decode(request.getParameter("ex_object2"),"utf-8"); 
	int ex_code = Integer.parseInt(request.getParameter("ex_code"));
	examDBBean db = examDBBean.getInstance();
	String dab = db.getDab(ex_object2, ex_code);
	
	int ex_sum = db.exsum(ex_object1, ex_object2, ex_code);
	int pp = 4;
	
	int pagenum = 1;
	if(request.getParameter("pagenum")!=null){
		pagenum = Integer.parseInt(request.getParameter("pagenum")); 
	}
%>    
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
	var inputdab = [<%= ex_sum+1 %>];
	var dab = '<%= dab %>';
	for (var i = 0; i < <%=ex_sum%>; i++) {
		inputdab[i] = 0;
	}
	
	function bo(i,j) {
		if (inputdab[i-1] == 0){
			inputdab[i-1] = j;
			document.images['image_'+i+'_'+j].src="../examimg/checked.jpg";
			console.log(inputdab);
			
		}else if(inputdab[i-1]==j){
			inputdab[i-1] = 0;
			document.images['image_'+i+'_'+j].src="../examimg/"+j+".jpg";
			console.log(inputdab);
		}else{
			var k = inputdab[i-1];
			inputdab[i-1] = j;
			document.images['image_'+i+'_'+k].src="../examimg/"+k+".jpg";
			document.images['image_'+i+'_'+j].src="../examimg/checked.jpg";
			console.log(inputdab);
		}
	}
	
	function cjclick(){
		parent.document.solveForm.inputdabs.value = inputdab;
		parent.document.solveForm.dab.value = dab;
		parent.document.solveForm.submit();
	}
	
</script>
</head>
<body style="padding: 0px">
				<form action="omrOk.jsp" method="post" name="omrForm">
					<caption><h3 style="color: blue">답안지</h3></caption>
					<%
						for(int k = 0; k<ex_sum; k+=10){
					%>
					<table border="1px solid black" style="float:left;">
						<%
							for(int i = 1; i <= 10; i++){
								if(i+k-1== ex_sum) break;
						%>
							<tr>
							<td style="background: aqua" >
								<%
									if(i+k < 10){
										String num = "00";
										num += Integer.toString(i+k);
										%>
											<%=num %>
										<%
									} else if(i+k >= 10 && i+k < 100) {
										String num = "0";
										num += Integer.toString(i+k);
										%>
											<%=num %>
										<%
									} else {
										%>
											<%=i+k %>
										<%
									}
								%>
							</td>
						<%
							for(int j = 1; j <= pp; j++){
						%>
							<label class="form-check-label"><td><img onclick="bo(<%= i+k%>,<%= j %>)" name="image_<%= i+k %>_<%= j %>" src="../examimg/<%= j %>.jpg"></td></label>
						<%
							}
						%>	
							</tr>
						<%		
							}
						%>
					</table>
					<%
						}
					%>
				</form>
	
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