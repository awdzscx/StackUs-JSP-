<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
	<%
		String inputdabs = request.getParameter("inputdabs");
	
		String dabs = request.getParameter("dab");
		
		ArrayList<Integer> odabList = new ArrayList<Integer>();
		
		StringTokenizer st = new StringTokenizer(inputdabs,",");
		ArrayList<Integer> inputdabList = new ArrayList<>();
		while(st.hasMoreTokens()){
			inputdabList.add(Integer.parseInt(st.nextToken()));
		}
		
		StringTokenizer st2 = new StringTokenizer(dabs,"/");
		ArrayList<Integer> dabList = new ArrayList<>();
		while(st2.hasMoreTokens()){
			dabList.add(Integer.parseInt(st2.nextToken()));
		}
		
	%>
	<%= dabList.size() %>	
	<%
		int qq = 100%dabList.size();
		int score= 100/dabList.size();
		int sum=0;
		
		int[] scoreArray = new int[dabList.size()];  
		for(int i = 0; i<dabList.size(); i++){
			scoreArray[i] = score; 
		}
		
		while(qq>0){
			int random = (int)(Math.random()*dabList.size());
			if(scoreArray[random] == score){
				scoreArray[random]	+= 1;
				qq--;
			} 
		}
		
		for(int i = 0; i<dabList.size();i++){
			if(dabList.get(i) == inputdabList.get(i)){
				sum += scoreArray[i];
				odabList.add(i);
			}
		}
	%>
	<h1><%= sum %>점 입니다!!</h1>
	
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