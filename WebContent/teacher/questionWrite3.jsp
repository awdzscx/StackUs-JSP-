<%@page import="java.util.ArrayList"%>
<%@page import="teacher.classDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); ;%>
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
		String mem_id = session.getAttribute("id").toString();
		classDBBean db = classDBBean.getInstance();
		ArrayList<String> list = db.getTclass(mem_id);
		session.setAttribute("mem_id", mem_id);
	%>
    <!-- Form Start -->
    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-xl-6">
                <form action="../teacher/questionWrite.jsp" method="post" name="quesForm">
                <div class="bg-light rounded h-100 p-4">
                    <h6 class="mb-4">클래스 선택</h6>
                        <div class="mb-3">
                            <br>
                            <div>
                            <select name="cla_name" class="form-select form-select-sm mb-3" aria-label=".form-select-sm example">
                            	<option selected="selected">클래스를 선택해주세요</option>
								<%
									for(int i = 0; i < list.size(); i++){
								%>
									<option value="<%= list.get(i)%>"><%= list.get(i)%></option>
								<%		
									}
								%>
                            </select>
                            </div>
                            <div id="emailHelp" class="form-text">We'll never share your answer with anyone else.
                            </div>
                        </div>
                        <input type="submit"  class="btn btn-primary" value="다음으로"></input>
                </div>
                    </form>
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