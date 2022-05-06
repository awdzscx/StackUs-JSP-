<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
	<%!
		public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
		}
	%>
	<%
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String mem_id = session.getAttribute("id").toString();	
	%>
    <!-- Form Start -->
    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-xl-6">
                <div class="bg-light rounded h-100 p-4">
                    <h6 class="mb-4">과목으로 클래스 검색하기</h6>
                    <form action="../member/subjectFindOk.jsp" accept-charset="UTF-8" method="post">
                    	<input type="hidden" name="mem_id" value="<%= mem_id %>">
                        <div class="mb-3">
                            <select class="form-select form-select-sm mb-3" aria-label=".form-select-sm example" name="search">
                                <option selected>검색할 과목을 선택하세요.</option>
                                <%
                                	Connection con = null;
                                	PreparedStatement pstmt = null;
                                	ResultSet rs = null;
                                	
                                	try{
                                		con = getConnection();
                                		String sql = "SELECT SUBJECT_SUBJECT_NAME FROM CLASS GROUP BY SUBJECT_SUBJECT_NAME ORDER BY SUBJECT_SUBJECT_NAME";
                                		pstmt = con.prepareStatement(sql);
                                		rs = pstmt.executeQuery();
	                                	while(rs.next()){
	                                		String subject = rs.getString(1);
	                            %>
                                <option value="<%=subject%>"><%= subject %></option>
	                            <%    		
	                                	}	
                                		
                                	}catch(Exception e){
                                		e.printStackTrace();
                                	}finally{
                     			       try {
                    				        if (rs != null)
                    				         rs.close();
                    				        if (pstmt != null)
                    				         pstmt.close();
                    				        if (con != null)
                    				         con.close();
                    				   } catch (SQLException se) {
                    				        System.out.println(se.getMessage());
                    				   }
                                	}
                                %>
                            </select>
                            <div id="emailHelp" class="form-text">We'll never share your answer with anyone else.
                            </div><br>
                        	<input class="btn btn-primary" type="submit" value="검색하기">
                        </div>
                    </form>
                    <button onclick="location.href='../member/findClass.jsp?mem_id=<%= mem_id %>'" class="btn btn-secondary text-center">이름으로 검색하러가기</button>
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