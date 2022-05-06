<%@page import="nl.captcha.Captcha"%>
<%@page import="member.MemberBean"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="member" class="member.MemberBean" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>DASHMIN - Bootstrap Admin Template</title>
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
    <!-- chapcha -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Imagetoolbar" content="no" />
	<script type="text/javascript"src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script type="text/javascript" src="../js/exam2.js?ver=1" charset="utf-8"></script>
</head>

<body>
<%
	session.setAttribute("keep", null);
	session.setAttribute("ex_type", null);
	session.setAttribute("ex_year", null);
	session.setAttribute("ex_no", null);
	
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
	if(request.getParameter("ex_type") != null){
		%>
		<%		
			}else{
%>
    <div class="container-xxl position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->

        <!-- Sign Up Start -->
        <div class="container-fluid">
            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3" >
                    	<form action="../exam/examWrite3.jsp" name="examForm" method="post">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <a href="../main/main.jsp" class="">
                                <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>STACK US</h3>
                            </a>
                                <p>문제 올리기</p>
                        </div>
                        
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" name="ex_name" id="floatingText" placeholder="jhondoe">
                            <label for="">과목이름을 검색하세요.</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" name="ex_year" id="floatingText" placeholder="jhondoe">
                            <label for="">시험연도를 입력하세요.</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" name="ex_no" id="floatingText" placeholder="jhondoe">
                            <label for="">시험회차를 입력하세요.</label>
                        </div>
                       
                        
                        <button type="button"  onclick="checkOK()"  class="btn btn-primary py-3 w-100 mb-4">확인</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Sign Up End -->
    </div>
	<%		
		}
	%>
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