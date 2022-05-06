<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="exam.exambean"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="exam.examDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
	
	examDBBean db = examDBBean.getInstance();
	String ex_object1 = URLDecoder.decode(request.getParameter("ex_object1"),"utf-8"); 
	String ex_object2 = URLDecoder.decode(request.getParameter("ex_object2"),"utf-8"); 
	int ex_code = Integer.parseInt(request.getParameter("ex_code"));
	int ex_sum = db.getEx_sum(ex_object2, ex_code);
	String dab = db.getDab(ex_object2, ex_code);
	
	ArrayList<exambean> list = db.getExam(ex_object1, ex_object2, ex_code);
	
	int pagenum = 1;
	if(request.getParameter("pagenum")!=null){
		pagenum = Integer.parseInt(request.getParameter("pagenum"));
	}
	
	int year = ex_code/100;
	int num = ex_code%100;
	exambean bean = list.get(pagenum-1);
%>    
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
    <script type="text/javascript">
    	function page() {
			document.solveForm.submit();
    	}
    </script>
</head>

<body>
	<form action="examSolve.jsp" method="post" name="solveForm">
		<input type="hidden" name="ex_object1" value="<%= URLEncoder.encode(ex_object1,"utf-8")%>" >
		<input type="hidden" name="ex_object2" value="<%= URLEncoder.encode(ex_object2,"utf-8")%>" >
		<input type="hidden" name="ex_code" value="<%= ex_code %>" >
		<input type="hidden" name="pagenum" value="<%= pagenum+1 %>">
	</form>
		<form action="examSolve.jsp" method="post" name="solvebeforeForm">
		<input type="hidden" name="ex_object1" value="<%= URLEncoder.encode(ex_object1,"utf-8")%>" >
		<input type="hidden" name="ex_object2" value="<%= URLEncoder.encode(ex_object2,"utf-8")%>" >
		<input type="hidden" name="ex_code" value="<%= ex_code %>" >
		<input type="hidden" name="before" value="true">
		<input type="hidden" name="pagenum" value="<%= pagenum-1 %>">
	</form>

    <!-- Form Start-->
    <center>
			<table width="100%" height="20">
				<tr>
					<td align="center" style="color:white; background-color: grey"><%= ex_object2+"  "+year+"년도 "+num+"회차 " %></td>
				</tr>
			</table>
			<hr>
				<table>
					<tr>
						<td align="center" valign="top"><b><%= bean.getEx_no()+"." %></b></td>
						<td colspan="2"><b><%= bean.getEx_content() %></b></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= pagenum-1 %>_1" class="1" alt="" src="../examimg/1.jpg" onclick="parent.bo(<%= pagenum-1 %>,1)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_first() %></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= pagenum-1 %>_2" class="2" alt="" src="../examimg/2.jpg" onclick="parent.bo(<%= pagenum-1 %>,2)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_second() %></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= pagenum-1 %>_3" class="3" alt="" src="../examimg/3.jpg" onclick="parent.bo(<%= pagenum-1 %>,3)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_third() %></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= pagenum-1 %>_4" class="4" alt="" src="../examimg/4.jpg" onclick="parent.bo(<%= pagenum-1 %>,4)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_fourth() %></td>
					</tr>
				</table>
				<br>
			</td>
		</tr>
	</table>		
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