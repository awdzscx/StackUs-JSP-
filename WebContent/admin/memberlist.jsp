<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");

String pageNum = request.getParameter("pageNum");

if(pageNum == null){
	pageNum = "1";
}

int sq = 0;
if(request.getParameter("sq") != null){
	sq = Integer.parseInt(request.getParameter("sq"));
	
}

MemberDBBean db = MemberDBBean.getInstance();
ArrayList<MemberBean> memberList = db.listmember(pageNum, 1, sq);

SimpleDateFormat frm = new SimpleDateFormat("yyyy-MM-dd");

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
                    <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-center" style="width: 10%">번호</th>
                                        <th scope="col" style="width: 18%" class="text-center">아이디</th>
                                        <th scope="col" style="width: 18%" class="text-center">생일</th>
                                        <th scope="col" style="width: 18%" class="text-center">이메일</th>
                                        <th scope="col" style="width: 18%" class="text-center">타입</th>
                                        <th scope="col" style="width: 18%" class="text-center">이름</th>
                                    </tr>
                                </thead>
                                <tbody >
                    <%
						for(int i=0; i < memberList.size(); i++){
							MemberBean member = memberList.get(i);
							String type = "";
							
							if(member.getMEM_TYPE() == 2){
								type = "Teacher";
							}else if(member.getMEM_TYPE() == 3){
								type = "Student";
							}
							
							String strDate = member.getMEM_BIRTH();
					        Date date = frm.parse(strDate);
					%>
                                    <tr onclick="location.href='memberlist.jsp?pageNum=<%= pageNum %>'">
                                        <th scope="row" class="text-center"><%=  member.getMEM_NO() %></th>
                                        <td class="text-center"><%= member.getMEM_ID() %></td>
                                        <td class="text-center"><%= frm.format(date) %></td>
                                        <td class="text-center"><%= member.getMEM_EMAIL() %></td>
                                        <td class="text-center"><%= type %></td>
                                        <td class="text-center"><%= member.getMEM_NAME() %></td>
                                    </tr>
                    <%
						}
					%>
                                </tbody>
                            </table>
							<div align="center">
								<%= MemberBean.pageNumber(5) %>
							</div>
                </div>
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