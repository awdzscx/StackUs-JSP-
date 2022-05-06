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
    <title>StackUs - Sign Up</title>
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
	<script type="text/javascript" src="../js/update.js?ver=1"></script>
	<script type="text/javascript">
		function inputYMDNumber(obj) {													
			if(event.keyCode != 8) {
	            if(obj.value.replace(/[0-9 \-]/g, "").length == 0) {
	                let number = obj.value.replace(/[^0-9]/g,"");
	                let ymd = "";
	                if(number.length < 4) {
	                    return number;
	                } else if(number.length < 6){
	                    ymd += number.substr(0, 4);
	                    ymd += "-";
	                    ymd += number.substr(4);
	                } else {
	                    ymd += number.substr(0, 4);
	                    ymd += "-";
	                    ymd += number.substr(4, 2);
	                    ymd += "-";
	                    ymd += number.substr(6);
	                }
	                obj.value = ymd;
	            } else {
	                alert("숫자 이외의 값은 입력하실 수 없습니다.");
	                obj.value = obj.value.replace(/[^0-9 ^\-]/g,"");
	                return false;
	            }
	        } else {
	            return false;
	        }
	    }
    
	</script>
</head>

<body>
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
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
                    	<form action="../main/mem_editOK.jsp" name="editfrm" method="post">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <a href="../main/main.jsp" class="">
                                <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>STACK US</h3>
                            </a>
                            <h3>Update</h3>
                        </div>
                    	<input id="email" name="MEM_TYPE" type="radio" value="3" checked="checked">학생
	           			<input id="email" name="MEM_TYPE" type="radio" value="2">교사<br>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" name="MEM_NAME" id="floatingText" placeholder="jhondoe">
                            <label for="">Username</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" name="MEM_EMAIL" id="floatingInput" placeholder="name@example.com">
                            <label for="floatingInput">Email address</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" name="MEM_BIRTH" id="floatingPassword" placeholder="1999-01-01" oninput="inputYMDNumber(this)" maxlength="10">
                            <label for="floatingInput">Birthday</label>
                        </div>                        
                        
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" name="MEM_PW" id="floatingPassword" placeholder="Password">
                            <label for="floatingPassword">Password</label>
                        </div>
                        
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" name="MEM_CONTENT" id="floatingPassword" placeholder="Introduce">
                            <label for="floatingPassword">Self Introduce</label>
                        </div>
                       
                        
                        <button type="button" class="btn btn-primary py-3 w-100 mb-4" onclick="signUpCheck()">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Sign Up End -->
    </div>

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