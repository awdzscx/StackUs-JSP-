<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exam.examDBBean"%>
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
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String mem_id = session.getAttribute("id").toString();
	%>
	<%  
		String ex_object1 = URLDecoder.decode(request.getParameter("ex_object1"),"utf-8");
		String ex_object2 = URLDecoder.decode(request.getParameter("ex_object2"),"utf-8"); 
		examDBBean db = examDBBean.getInstance();
	%>
    <!-- Form Start -->
    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-xl-6">
                <div class="bg-light rounded h-100 p-4">
                    <h6 class="mb-4">기출문제 선택</h6>
                    <form action="../exam/final1.jsp" name="examForm" method="post">
                    	<input type="hidden" name="mem_id" value="<%= mem_id %>">
                    	<input type="hidden" value="<%= URLEncoder.encode(ex_object1,"utf-8") %>" name="ex_object1">
                    	<input type="hidden" name="ex_object2" value="<%= URLEncoder.encode(ex_object2,"utf-8")%>">
                    		<div class="form-floating mb-3">
                    			<select class="form-select" id="floatingSelect" name="ex_code"
                    			aria-label="Floating label select example">
								<%
									ArrayList<Integer> list = db.getCode(ex_object1, ex_object2);
									for(int i =0; i < list.size(); i++){
										int code = list.get(i);
										int year = code/100;
										int num = code%100;
								%>
									<option value="<%= list.get(i) %>"><%= year+"년도 "+num+"회차" %></option>
								<%		
									}
								%>
								</select>
								 <label for="floatingSelect">Works with selects</label>
                            </div>
                        <button type="submit" class="btn btn-primary">풀기</button>
                    </form>
                </div>
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