<%@page import="java.util.ArrayList"%>
<%@page import="teacher.classDBBean"%>
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
    <script type="text/javascript" src="../js/class.js"></script>
</head>
<body>
	
		<div>
			<form action="class_open.jsp" method="post" name="clafrm">
					    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-xl-6">
            	<%= session.getAttribute("id") %>
							<h3>클래스 생성하기</h3>
				             <div class="form-floating mb-3">
                                <input type="text" name="CLA_NAME" class="form-control" id="floatingInput"
                                    placeholder="클래스이름">
                                <label for="floatingInput">클래스 이름</label>
                            </div>
                            <div class="form-floating">
                                <textarea name="CLA_INTRO" class="form-control" placeholder="클래스 설명"
                                    id="floatingTextarea" style="height: 150px;"></textarea>
                                <label for="floatingTextarea">클래스 설명</label>
                            </div><br>
                            <div class="form-floating mb-3">
                                <select name="SUBJECT_SUBJECT_NAME" class="form-select" id="floatingSelect"
                                    aria-label="Floating label select example">
                                    <option value = "자유" selected>자유과목</option>
									<option value="국어">국어</option>
									<option value="영어">영어</option>
									<option value="수학">수학</option>
									<option value="사회">사회</option>
									<option value="과학">과학</option>
									<option value="예체능">예체능</option>
									<option value="토익">토익</option>
									<option value="토플">토플</option>
									<option value="토스">토스</option>
									<option value="공무원">공무원</option>
									<option value="경찰">경찰</option>
									<option value="소방">소방</option>
									<option value="한국사">한국사</option>
									<option value="중국어">중국어</option>
									<option value="일본어">일본어</option>
									<option value="독일어">독일어</option>
									<option value="프랑스어">프랑스어</option>
									<option value="기타어학">기타어학</option>
                                </select>
                                <label for="floatingSelect">과목을 선택하세요.</label>
                            </div>
				<input type="button" class="btn btn-outline-primary m-2" value="클래스 생성" onclick="classOk()">&nbsp;&nbsp;&nbsp;
				</div></div></div>
			</form>
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