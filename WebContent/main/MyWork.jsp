<%@page import="comment.CommentBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="exam.examnamebean"%>
<%@page import="exam.examDBBean"%>
<%@page import="exam.exambean"%>
<%@page import="my.likeBean"%>
<%@page import="my.commentsBean"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
		String res="";
		
		String id = session.getAttribute("id").toString();
		
		MemberDBBean db = MemberDBBean.getInstance();
		ArrayList<BoardBean> myWri = db.getMyWrite(id);
		ArrayList<CommentBean> myCom = db.getMyreply(id);
		ArrayList<likeBean> myLike = db.getMyLike(id);
		ArrayList<String> licenseList = db.licenseList(id);
		String img = db.getMyimg(id);
		
		examDBBean eb = examDBBean.getInstance();
		ArrayList<exambean> examres = eb.myresult(id);
		
		int type = db.getType(id);
		String mem_type = "";
		
		if(type == 3){
			mem_type = "Student";
		}else if(type == 2){
			mem_type = "Teacher";
		}else{
			mem_type = "Admin";
		}
		
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		
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
    <script type="text/javascript" src="../js/jquery.js"></script>
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


        <!-- MyAccount Side bar start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="../main/main.jsp" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>STACK US</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                <%
                	if(session.getAttribute("id")!= null){
				%>
                        <img class="rounded-circle" src="../images/<%= img %>" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0"><%= id %></h6>
                        <span><%= mem_type %></span>
                    </div>
				<%
                	}else{
                %>
                      <!--<img class="rounded-circle" src="../img/1235.jpg" alt="" style="width: 40px; height: 40px;"> -->
                        <i class="bi bi-box-arrow-in-left" style="font-size: 2rem; color: #389dff"></i>
                        <!-- <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div> -->
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0 popLogin"><a href="../main/mem_signin.jsp">로그인</a></h6>
                        <span>비회원</span>
                    </div>
                <%		
                	}
                %>
                </div>
                
                
                <div class="navbar-nav w-100">
                    <a href="../main/MyAccount.jsp" class="nav-item nav-link"><i class="bi bi-person-circle me-2"></i>My Page</a>
                    <a href="../main/MyProfile.jsp" class="nav-item nav-link"><i class="bi bi-journal-richtext me-2"></i>Profile</a>
                    <a href="../main/MyWork.jsp" class="nav-item nav-link active"><i class="bi bi-file-earmark-text me-2"></i>My Work</a>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->


        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                <a href="../main/main.jsp" class="navbar-brand d-flex d-lg-none me-4">
                    <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                </a>
                <a href="#" class="sidebar-toggler flex-shrink-0">
                    <i class="fa fa-bars"></i>
                </a>
                <form class="d-none d-md-flex ms-4" action="../main/search.jsp">
                	<select name="selbox" class="form-select" aria-label="Default select example" style="width: 100px;">
                		<option value="제목">제목</option>
                		<option value="작성자">작성자</option>
                		<option value="내용">내용</option>
                	</select>
                    &nbsp;&nbsp;&nbsp;<input name="search" class="form-control border-0" type="search" placeholder="Search">
                </form>
                <div class="navbar-nav align-items-center ms-auto">
                    <div class="nav-item dropdown">
                <%
                	if(session.getAttribute("id")!= null){
				%>    
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <img class="rounded-circle me-lg-2" src="../images/<%= img %>" alt="" style="width: 40px; height: 40px;">
                            <span class="d-none d-lg-inline-flex"><%= id %></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="../main/MyAccount.jsp" class="dropdown-item">마이페이지</a>
                            <a href="../main/mem_edit.jsp" class="dropdown-item">수정하기</a>
                            <a href="../main/logout.jsp?href=../main/main.jsp" class="dropdown-item">로그아웃</a>
                        </div>
                <%
                	}else{
                %>
                            <button class="btn btn-outline-primary m-2">Login</button>
                <%		
                	}
				%>    
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->


            <!-- Table Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                   <div class="col-sm-12 col-xl-6">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">My Write</h6>
                            <table class="table table-striped">
                           		 <%
									if(myWri.size()==0){
										out.println("작성한 글이 없습니다.");
									}else{
								
								%>
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">제목</th>
                                        <th scope="col">내용</th>
                                        <th scope="col">날짜</th>
                                    </tr>
                                </thead>
                                <% } %>
                                <tbody>
                                <%
									if(myWri.size()==0){
									}else{
								
									for(int i = 0; i < myWri.size(); i++){
																				
										BoardBean b = myWri.get(i);
								%>
                                   <tr>
										<th scope="row">
											<%= i+1 %>
										</th>		
										<td>
											<a href="http://localhost:8484/stackus/board/show.jsp?bo_no=<%= db.getBoNo(b.getBo_title(), b.getBo_content(), b.getBo_date()) %>"><%= b.getBo_title() %></a>
										</td>		
										<td>
											<%= b.getBo_content() %>
										</td>		
										<td>
											<%= fm.format(b.getBo_date()) %>
										</td>		
									</tr>
								<%
									if(i==4){
										out.println("5개의 최신 정보만 표시됩니다.");
										break;
									}
									}
									}
								%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">My Comment</h6>
                            <table class="table table-striped">
                            	<%
									if(myCom.size()==0){
										out.println("작성한 댓글이 없습니다.");
									}else{
								
								%>
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">내용</th>
                                        <th scope="col">날짜</th>
                                    </tr>
                                </thead>
                                <% } %>
                                <tbody>
                                <%
									if(myCom.size()==0){
									}else{
								
									for(int i = 0; i < myCom.size(); i++){
										CommentBean like = myCom.get(i);
								%>
                                   <tr>
										<th scope="row" style="width: 10%;">
											<%= i+1 %>
										</th>		
										<td style="width: 40%;">
											<a href="http://localhost:8484/stackus/board/show.jsp?bo_no=<%= db.getCBoNo(like.getCo_nom(), like.getCo_content(), like.getCo_date()) %>"><%= like.getCo_content() %></a>
										</td>		
										<td>
											<%= fm.format(like.getCo_date()) %>
										</td>		
									</tr>
								<%
									if(i==4){
										out.println("5개의 최신 정보만 표시됩니다.");
										break;
									}
									}
									}
								%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">My Like</h6>
                            <table class="table table-striped">
                           		 <%
									if(myLike.size()==0){
										out.println("좋아요한 글이 없습니다.");
									}else{
								
								%>
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">제목</th>
                                    </tr>
                                </thead>
                                <% } %>
                                <tbody>
                                <%
									if(myLike.size()==0){
									}else{
								
									for(int i = 0; i < myLike.size(); i++){
										likeBean like = myLike.get(i);
										int bono = like.getBOARD_BO_NO();
								%>
									<tr>
										<th scope="row">
											<%= i+1 %>
										</th>	
										<td>
											<%= db.getLikeBoardName(bono) %>
										</td>		
									</tr>
								<%
									if(i==4){
										out.println("5개의 최신 정보만 표시됩니다.");
										break;
									}
									}
									}
								%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">My License</h6>
                            <table class="table table-striped">
                            <%
									if(licenseList.size()==0){
										out.println("등록된 자격증이 없습니다.");
									}else{
								
								%>
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">자격증 이름</th>
                                    </tr>
                                </thead>
                                <% } %>
                                <tbody>
                                <%
									if(licenseList.size()==0){
									}else{
								
									for(int i = 0; i < licenseList.size(); i++){
										String license = licenseList.get(i);
								%>
									<tr>
										<th scope="row">
											<%= i+1 %>
										</th>	
										<td>
											<%= license %>
										</td>	
									</tr>
								<%
									}
									}
								%>
                                </tbody>
                            </table>
                            <br><br>
                            <div class="d-flex align-items- justify-content-between mb-4" style="">
								<label></label>
								<input type="button" value="자격증 추가" onclick="location.href='../main/mem_license.jsp'" class="btn btn-outline-primary">
							</div>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">My Exam</h6>
                            <table class="table table-striped">
                            <%
									if(examres.size()==0){
										out.println("친 시험이 없습니다");
									}else{
								
								%>
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">이름</th>
                                        <th scope="col">회차</th>
                                        <th scope="col">점수</th>
                                    </tr>
                                </thead>
                                <% } %>
                                <tbody>
                                <%
									if(examres.size()==0){
									}else{
								
									for(int i = 0; i < examres.size(); i++){
										examnamebean ex = new examnamebean();
										exambean exam = examres.get(i);
										String ex_object2 = exam.getEx_object2();
										int code = exam.getEx_code();
										int year = code/100;
										int no = code%100;
										int score = exam.getScore();
								%>
									<tr>
										<th scope="row">
											<%= i+1 %>
										</th>	
										<td>
											<%= ex_object2 %>
										</td>		
										<td>
											<%= year+"년도"+no+"회차" %>
										</td>		
										<td>
											<%= score+"점" %>
										</td>		
									</tr>
								<%
									if(i==4){
										out.println("5개의 최신 정보만 표시됩니다.");
										break;
									}
									}
									}
								%>
								
                                </tbody>
                            </table>
                            <br><br>
                            
                        </div>
                    </div>
                    
            <!-- Table End -->


             <!-- Footer Start -->
            <div class="container-fluid bg-white pt-5 px-3">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                             &copy; <a href="../main/main.jsp">StackUs</a>, All Right Reserved. 
                        </div>
                        <div class="col-12 col-sm-6 text-center text-sm-end">
                            <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                            Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                        </br>
                        Customer Service <a class="border-bottom" href="https://themewagon.com" target="_blank">ThemeWagon</a>
                        </div>
                </div>
            </div>
            <!-- Footer End -->
        </div>
        <!-- Content End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
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