<%@page import="java.sql.SQLException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
	<script type="text/javascript">
    $(function(){
		$(".pop_exam").click(function(){
			var popUrl = "../exam/examMain.jsp";
			var popOption = "width=650px, height = 550px, resizable= no, location=no,top=300px,left=300px";
			window.open("../exam/examMain.jsp","기출문제 풀기","width=650px, height = 550px");
		});
		
		$(".pop_question").click(function(){
			var popUrl = "../teacher/questionWrite.jsp";
			var popOption = "width=650px, height = 550px, resizable= no, location=no,top=300px,left=300px";
			window.open("../teacher/questionWrite.jsp","기출문제 풀기","width=650px, height = 550px");
		});
     }); 
	</script>
</head>
<body>
	<%!
	public Connection getConnection() throws Exception{
	Context ctx = new InitialContext();
	DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
	return ds.getConnection();
	}
	%>
	<center>
		    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-xl-6">
		<div>
			<h3>클래스 삭제하기</h3><br>
			<form action="delete_class_ok.jsp">
			                 <div class="form-floating mb-3">
                                <select name="CLA_NAME" class="form-select" id="floatingSelect"
                                    aria-label="Floating label select example">

<%
				  String mem_id = session.getAttribute("id").toString();
			      Connection con = null;
			      PreparedStatement pstmt = null;
			      ResultSet rs = null;
			      try {
			       con = getConnection();
			       String sql = "SELECT DISTINCT CLA_NAME FROM CLASS WHERE MEMBER_MEM_ID = ?";
			       pstmt = con.prepareStatement(sql);
				   pstmt.setString(1, mem_id);
			       rs = pstmt.executeQuery();
			       while (rs.next()) {
			        String CLA_NAME = rs.getString("CLA_NAME");
%>

     		<option value="<%=CLA_NAME%>"><%=CLA_NAME%></option>
<%
			      }
			      } catch (SQLException se) {
			       System.out.println(se.getMessage());
			      } finally {
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
                                <label for="floatingSelect">클래스를 지정하세요</label>
                            </div>
			<br><br>
			                            <div class="form-floating mb-3">
                                <input name="MEM_PW" type="password" class="form-control" id="floatingPassword"
                                    placeholder="Password">
                                <label for="floatingPassword">비밀번호를 입력하세요</label>
                            </div>
			<input type="submit" class="btn btn-dark m-2" value="클래스 삭제하기">
			</form>
		</div>
		</div>
		</div>
		</div>
		</center>

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