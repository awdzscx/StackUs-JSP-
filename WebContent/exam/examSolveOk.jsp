<%@page import="java.net.URLDecoder"%>
<%@page import="exam.examDBBean"%>
<%@page import="exam.exambean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
</head>
<body>
	<%
	
		
	%>
	<%
		String inputdabs = request.getParameter("inputdabs");
		String dab = request.getParameter("dab");
		ArrayList<Integer> inputdabList = new ArrayList<>();
		ArrayList<Integer> dabList = new ArrayList<>();
		ArrayList<Integer> odabList = new ArrayList<>();
		
		
		StringTokenizer st = new StringTokenizer(inputdabs,"/");
		
		if(request.getParameter("type")!=null){
			if(request.getParameter("type").equals("omr")){
				st = new StringTokenizer(inputdabs,",");
			}
		}
			
		while(st.hasMoreTokens()){
			inputdabList.add(Integer.parseInt(st.nextToken()));
		}
		
		StringTokenizer st2 = new StringTokenizer(dab,"/");
		while(st2.hasMoreTokens()){
			dabList.add(Integer.parseInt(st2.nextToken()));
		}
		
		
		int qq = 100%dabList.size();
		int score = 100/dabList.size();
		int sum = 0;
		
		int[] scoreArray = new int[dabList.size()];
		
		for(int i = 0; i<dabList.size();i++){
			scoreArray[i]=score;
		}
		
		while(qq>0){
			int random = (int)(Math.random()*dabList.size());
			if(scoreArray[random]==score){
				scoreArray[random] += 1;
				qq--;
			}
		}
		
		for(int i = 0; i< dabList.size(); i++){
			if(inputdabList.get(i)==dabList.get(i)){
				sum += scoreArray[i];
			}else{
				odabList.add(i);
			}
		}
	%>
	
	
	
	<%		
			String mem_id = request.getParameter("mem_id");
			String ex_object1 = URLDecoder.decode(request.getParameter("ex_object1"),"utf-8"); 
			String ex_object2 = URLDecoder.decode(request.getParameter("ex_object2"),"utf-8"); 
			int ex_code = Integer.parseInt(request.getParameter("ex_code"));
			int year = ex_code/100;
			int num = ex_code%100;
			
			examDBBean db = examDBBean.getInstance();
			db.insertResult(sum, ex_object2, ex_code, mem_id);
			ArrayList<exambean> list = db.getExam(ex_object1, ex_object2, ex_code);
			for(int k =0; k<odabList.size(); k++){
				int i = odabList.get(k);			
				exambean bean = list.get(i);

	%>
	<%		
				if(k==0){
	%>
		<table width="100%" height="20">
					<tr>
						<td align="center" style="color:white; background-color: grey;"><%= ex_object2+"  "+year+"년도 "+num+"회차 " %></td>
					</tr>
				</table>
				<hr>
	<%			
				}
	%>
			<center>
				<table width="80%">
					<tr>
						<td align="center" valign="top"><b><%= bean.getEx_no()+"." %></b></td>
						<td colspan="2"><b><%= bean.getEx_content() %></b></td>
					</tr>
					<tr>
						<td></td>
						<%
							if(db.getRight(ex_object2, ex_code, i+1)==1){
						%>
						<td width="0%" style="color: green;"><img name="image_<%= i %>_1" class="1" alt="" src="../examimg/checked.jpg"></td>
						<td style="text-align: left; width: 94%; color: green;"><%= bean.getEx_first() %></td>
						<%		
							}else{
						%>
						<td width="0%"><img name="image_<%= i %>_1" class="1" alt="" src="../examimg/1.jpg"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_first() %></td>
						<%		
							}
						%>
					</tr>
					<tr>
						<td></td>
						<%
							if(db.getRight(ex_object2, ex_code, i+1)==2){
						%>
						<td width="0%" style="color: green;"><img name="image_<%= i %>_2" class="2" alt="" src="../examimg/checked.jpg"></td>
						<td style="text-align: left; width: 94%; color: green;"><%= bean.getEx_second() %></td>
						<%		
							}else{
						%>
						<td width="0%"><img name="image_<%= i %>_2" class="2" alt="" src="../examimg/2.jpg"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_second() %></td>
						<%		
							}
						%>
					</tr>
					<tr>
						<td></td>
												<%
						if(db.getRight(ex_object2, ex_code, i+1)==3){
						%>
						<td width="0%" style="color: green;"><img name="image_<%= i %>_3" class="3" alt="" src="../examimg/checked.jpg"></td>
						<td style="text-align: left; width: 94%; color: green;"><%= bean.getEx_third() %></td>
						<%		
							}else{
						%>
						<td width="0%"><img name="image_<%= i %>_3" class="3" alt="" src="../examimg/3.jpg"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_third() %></td>
						<%		
							}
						%>
					</tr>
					<tr>
						<td></td>
						<%
							if(db.getRight(ex_object2, ex_code, i+1)==4){
						%>
						<td width="0%" style="color: green;"><img name="image_<%= i %>_4" class="4" alt="" src="../examimg/checked.jpg"></td>
						<td style="text-align: left; width: 94%; color: green;"><%= bean.getEx_fourth() %></td>
						<%		
							}else{
						%>
						<td width="0%"><img name="image_<%= i %>_4" class="4" alt="" src="../examimg/4.jpg"></td>
						<td style="text-align: left; width: 94%"><%= bean.getEx_fourth() %></td>
						<%		
							}
						%>
					</tr>
					<tr>
						<td colspan="3" align="right" style="color: green;">
							<%= "정답 :"+db.getRight(ex_object2, ex_code, i+1) %>
						</td>
					</tr>
				</table>
			</center>	
				<br>
	<%		
			}
	%>
			</td>
		</tr>
		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
		&emsp;&emsp;&emsp;&emsp;&emsp;
		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<button class="btn btn-success m-2" onclick="window.close()">종료하기</button>
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