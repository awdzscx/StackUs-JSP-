<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="teacher.classDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
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
		<%= 
			session.getAttribute("cla_name")
		%>
		<%= request.getParameter("q_fname") %>
	<% 
		String cla_name = session.getAttribute("cla_name").toString();
		classDBBean db = classDBBean.getInstance();
		String subject = db.getSubject(cla_name);
	%>
	    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-xl-6">
	<form action="questionWriteOk2.jsp" name="examForm2" method="post">
		<input type="hidden" name="cla_name" value="<%= session.getAttribute("cla_name") %>">
		<input type="hidden" name="mem_id" value="<%= session.getAttribute("mem_id") %>">
		<input type="hidden" name="q_fname" value="<%= URLDecoder.decode(request.getParameter("q_fname"),"utf-8")  %>">
		<input type="hidden" name="subject_subject_name" value="<%=subject%>">
		                    <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="floatingInput"
                                    placeholder="문제제목을 입력하세요." name="q_title">
                                <label for="floatingInput">문제 제목</label>
                            </div>
				            <div class="form-floating">
                                <textarea class="form-control" placeholder="문제를 입력하세요."
                                    id="floatingTextarea" name="q_explain" style="height: 150px;"></textarea>
                                <label for="floatingTextarea">문제입력</label>
                            </div>
                            <br>
				            <div class="form-floating">
                                <textarea class="form-control" placeholder="해설을 입력하세요."
                                    id="floatingTextarea" name="q_answer" style="height: 150px;"></textarea>
                                <label for="floatingTextarea">해설입력</label>
                            </div>
                            <br>
                                <input type="radio" class="btn-check" value="1" name="q_right" id="btnradio1" autocomplete="off"
                                    checked>
                                <label class="btn btn-outline-primary"  for="btnradio1">1번</label>
                                <input type="radio" class="btn-check" value="2" name="q_right" id="btnradio2" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btnradio2">2번</label>
                                <input type="radio" class="btn-check" value="3" name="q_right" id="btnradio3" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btnradio3">3번</label>
                                <input type="radio" class="btn-check" value="4" name="q_right" id="btnradio4" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btnradio4">4번</label><hr>
								<div class="form-floating mb-3">
	                                <input type="text" class="form-control" id="floatingInput"
	                                    placeholder="name@example.com" name="a1">
	                                <label for="floatingInput">1번문제보기를입력하세요.</label>
                            	</div>
								<div class="form-floating mb-3">
	                                <input type="text" class="form-control" id="floatingInput"
	                                    placeholder="name@example.com" name="a2">
	                                <label for="floatingInput">2번문제보기를입력하세요.</label>
                            	</div>

								<div class="form-floating mb-3">
	                                <input type="text" class="form-control" id="floatingInput"
	                                    placeholder="name@example.com" name="a3">
	                                <label for="floatingInput">3번문제보기를입력하세요.</label>
                            	</div>
                                
								<div class="form-floating mb-3">
	                                <input type="text" class="form-control" id="floatingInput"
	                                    placeholder="name@example.com" name="a4">
	                                <label for="floatingInput">4번문제보기를입력하세요.</label>
                            	</div>
                            <br><br>
					<input type="submit" class="btn btn-primary " value="입력하기">
					<input type="reset" class="btn btn-outline-primary" style="margin-left: 10px" value="다시쓰기">
					</div></div></div>
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