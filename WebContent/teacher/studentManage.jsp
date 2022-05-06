<%@page import="teacher.classBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="teacher.classDBBean"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>    
<%
	String cla_name=  session.getAttribute("cla_name").toString();
	
	classDBBean db = classDBBean.getInstance();
	ArrayList<classBean> mycla = db.getClaMem(cla_name);

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
</head>
<body>

	  <div class="container-fluid pt-4 px-4" style="text-align: center;">
                <div class="row g-4">
                    <div class="col-sm-6 col-xl-3">
                        	<table class="table table-striped" style="width: 400px; text-align: center; margin-left: auto; margin-right: auto;">
                           		 <%
                           		 	if(mycla.size()==0){
                           		 		out.println("등록된 학생이 없습니다.");
                           		 	}else{
                           		 %>
                                <thead>
                                    <tr>
                                        <th scope="col" width="5%;">#</th>
                                        <th scope="col" width="30%;">클래스 이름</th>
                                        <th scope="col" width="20%;">이름</th>
                                        <th scope="col" width="20%;">포인트</th>
                                        <th scope="col" width="25%;">학생 강퇴</th>
                                    </tr>
                                </thead>
                                <%
                           		 	}
								%>
                                <tbody>
                                 <%
                           		 	if(mycla.size()==0){
                           		 	}else{
                           		 		for(int i = 0; i < mycla.size(); i++){
                           		 			classBean c = mycla.get(i);
                           		 			String num = c.getMember_mem_id();
                           		 %>
                                   <tr>
										<th scope="row">
											<%= i+1 %>
										</th>		
										<td>
											<%= session.getAttribute("cla_name") %>
										</td>		
										<td>
											<%= c.getMember_mem_id() %>
										</td>		
										<td>
											<%= c.getCla_point() %>
										</td>	
										
										<td>
											<input type="button" value="강퇴" onclick="button_event('<%= num %>')">
										</td>		
									</tr>
								<%
                           		 	}
                           		 	}
								%>
                                </tbody>
                            </table>
                    </div>
                    
                </div>
            </div>
            <script type="text/javascript">
											function button_event(num){
											if (confirm("정말 강퇴하시겠습니까??") == true){    //확인
												location.href='../teacher/studentManageDel.jsp?id='+num+'&cla_name=<%=cla_name%>';
											}else{   //취소
											    return;
											}
											}
			</script>	
		
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