<%@page import="exam.exambean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exam.examDBBean"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String ex_object1 = URLDecoder.decode(request.getParameter("ex_object1"),"utf-8"); 
	String ex_object2 = URLDecoder.decode(request.getParameter("ex_object2"),"utf-8"); 
	int ex_code = Integer.parseInt(request.getParameter("ex_code"));
	examDBBean db = examDBBean.getInstance();
	String dab = db.getDab(ex_object2, ex_code);
	
	int pagenum = 1;
	if(request.getParameter("pagenum")!=null){
		pagenum = Integer.parseInt(request.getParameter("pagenum")); 
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
<!-- <script type="text/javascript">
	
	function bo(i,j) {
		if (inputdab[i] == 0){
			inputdab[i] = j;
			document.images['image_'+i+'_'+j].src="../exam/checked.jpg";
			parent.right.document.images['image_'+(i+1)+'_'+j].src="../exam/checked.jpg";
			console.log(inputdab);
			
		}else if(inputdab[i]==j){
			inputdab[i] = 0;
			document.images['image_'+i+'_'+j].src="../exam/"+j+".jpg";
			parent.right.document.images['image_'+(i+1)+'_'+j].src="../exam/"+j+".jpg";
			console.log(inputdab);
		}else{
			var k = inputdab[i];
			inputdab[i] = j;
			document.images['image_'+i+'_'+k].src="../exam/"+k+".jpg";
			document.images['image_'+i+'_'+j].src="../exam/checked.jpg";
			parent.right.document.images['image_'+(i+1)+'_'+k].src="../exam/"+k+".jpg";
			parent.right.document.images['image_'+(i+1)+'_'+j].src="../exam/checked.jpg";
			console.log(inputdab);
		}
	}
	
</script> -->
</head>
<body>
	<% 
		int year = ex_code/100;
		int num = ex_code%100;
		
		ArrayList<exambean> list = db.getExam(ex_object1, ex_object2, ex_code);
	%>
	<table border="1px solid blue" style="width: 100%; float: left;">
		<tr>
			<td width="35%">
	<%	
	
		int dd = db.exsum(ex_object1, ex_object2, ex_code); //14
		int start = 0;
		int right = 6;
		int left = 3;
		if(request.getParameter("pagenum")!=null){
			start += (pagenum-1)*6; //12
			left += (pagenum-1)*6; //15
			right += (pagenum-1)*6; //18
			if(left > dd) left = dd;	//15
			if(right > dd) right = dd;	
		}
	
		
		for(int i = start; i < left; i++){
			exambean bean = list.get(i);

	%>
	<%		
			if(i==start){
	%>
			<table width="100%" height="20">
				<tr>
					<td align="center" style="background-color: black;color:white;"><%= ex_object2+"  "+year+"년도 "+num+"회차 " %></td>
				</tr>
			</table>
			<hr>
	<%			
			}
	%>
				<table>
					<tr>
						<td align="center" valign="top"><b><%= bean.getEx_no()+"." %></b></td>
						<td colspan="2"><b><%= bean.getEx_content() %></b></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= i %>_1" class="1" alt="" src="../examimg/1.jpg" onclick="parent.right.bo(<%= i+1 %>,1)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_first() %></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= i %>_2" class="2" alt="" src="../examimg/2.jpg" onclick="parent.right.bo(<%= i+1 %>,2)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_second() %></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= i %>_3" class="3" alt="" src="../examimg/3.jpg" onclick="parent.right.bo(<%= i+1 %>,3)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_third() %></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= i %>_4" class="4" alt="" src="../examimg/4.jpg" onclick="parent.right.bo(<%= i+1 %>,4)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_fourth() %></td>
					</tr>
				</table>
				<br>
	<%		
		}
	%>
			</td>
			<td width="35%" valign="top">
	<%	
		for(int i = left; i < right; i++){
			exambean bean = list.get(i);
			
	%>
				<table>
					<tr>
						<td align="center" valign="top"><b><%= bean.getEx_no()+"." %></b></td>
						<td colspan="2"><b><%= bean.getEx_content() %></b></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= i %>_1" class="1" alt="" src="../examimg/1.jpg" onclick="parent.right.bo(<%= i+1 %>,1)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_first() %></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= i %>_2" class="2" alt="" src="../examimg/2.jpg" onclick="parent.right.bo(<%= i+1 %>,2)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_second() %></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= i %>_3" class="3" alt="" src="../examimg/3.jpg" onclick="parent.right.bo(<%= i+1 %>,3)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_third() %></td>
					</tr>
					<tr>
						<td></td>
						<td width="0%"><img name="image_<%= i %>_4" class="4" alt="" src="../examimg/4.jpg" onclick="parent.right.bo(<%= i+1 %>,4)"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_fourth() %></td>
					</tr>
				</table>
				<br>
	<%		
		}
	%>		</td>
		</tr>
	</table>	
	
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