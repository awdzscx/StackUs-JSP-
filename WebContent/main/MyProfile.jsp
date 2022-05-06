<%@page import="teacher.classBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="teacher.classDBBean"%>
<%@page import="java.util.Date"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	MemberDBBean db = MemberDBBean.getInstance();
	classDBBean cla = classDBBean.getInstance();
	String mem_id = session.getAttribute("id").toString();
	String img = db.getMyimg(mem_id);
	String con = db.getMyCon(mem_id);
	
	ArrayList<classBean> myCla = cla.classList(mem_id);
	
	int type = db.getType(mem_id);
	String mem_type = "";
	
	if(type == 3){
		mem_type = "Student";
	}else if(type == 2){
		mem_type = "Teacher";
	}else{
		mem_type = "Admin";
	}
%>
<!DOCTYPE html>
<html>

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
    <script type="text/javascript" src="../js/update.js"></script>
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
                        <h6 class="mb-0"><%= mem_id %></h6>
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
                    <a href="../main/MyProfile.jsp" class="nav-item nav-link active"><i class="bi bi-journal-richtext me-2"></i>Profile</a>
                    <a href="../main/MyWork.jsp" class="nav-item nav-link"><i class="bi bi-file-earmark-text me-2"></i>My Work</a>
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
                            <span class="d-none d-lg-inline-flex"><%= mem_id %></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="../main/MyAccount.jsp" class="dropdown-item">마이페이지</a>
                            <a href="#마이페이지" class="dropdown-item">수정하기</a>
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

			<!-- Sales Chart Start -->
			
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4" style="height: 95%;">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">My Profile</h6>
                            </div>
                            <div class="d-flex align-items-center justify-content-between mb-4">
                            	<h6 class="mb-0">프로필 사진 바꾸기 : </h6><br>
                            </div>
								<form method="post" action="my_Image_Upload.jsp" enctype="multipart/form-data" name="imgfrm">
							<div class="d-flex align-items-center justify-content-between mb-4">
									<input type="file" name="profimg" class="form-control form-control-sm" id="formFileSm">
							</div>
									<input type="button" value="확인" class="btn btn-outline-primary" onclick="imgCheck()">
								</form>
								<br><br><br><br><br>
								
							<div class="d-flex align-items- justify-content-between mb-4" style="">
								<label></label>
								<input type="button" value="회원 탈퇴" onclick="location.href='../main/mem_delete.jsp'" class="btn btn-outline-primary">
							</div>
                        </div>
                    </div>
				<!-- 시험 예약 start  -->
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4" style="height: 95%;">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">Reservation</h6>
                            </div>
                            <div class="d-flex align-items-center justify-content-between mb-4">
                            	<h6 class="mb-0">시험 예약 : </h6><br>
                            </div>
                            
							<form method="post" action="reservation_ok.jsp" name="resfrm">
							
	                            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" name="ex_name" style="text-align: center" size="4">
								  <option selected>과목선택</option>
								  <option value="가스기사">가스기사</option>
								  <option value="정보처리기사">정보처리기사</option>
								  <option value="가구제작기능사">가구제작기능사</option>
								  <option value="가맹거래사">가맹거래사</option>
								  <option value="가스기능사">가스기능사</option>
								  <option value="가스기능장">가스기능장</option>
								  <option value="가스산업기사">가스산업기사</option>
								  <option value="건설기계설비기사">건설기계설비기사</option>
								  <option value="건설기계설비산업기사">건설기계설비산업기사</option>
								  <option value="건설기계정비기능사">건설기계정비기능사</option>
								  <option value="건설기계정비기능장">건설기계정비기능장</option>
								  <option value="건설기계정비기능장">건설기계정비기능장</option>
								  <option value="건설안전기사">건설안전기사</option>
								  <option value="건설안전산업기사">건설안전산업기사</option>
								  <option value="건설재료시험기능사">건설재료시험기능사</option>
								  <option value="건설재료시험기사">건설재료시험기사</option>
								  <option value="건설재료시험산업기사">건설재료시험산업기사</option>
								  <option value="건축기사">건축기사</option>
								  <option value="건축목공산업기사">건축목공산업기사</option>
								  <option value="건축목재시공기능장">건축목재시공기능장</option>
								  <option value="건축산업기사">건축산업기사</option>
								  <option value="건축설비기사">건축설비기사</option>
								  <option value="건축설비산업기사">건축설비산업기사</option>						
								  <option value="건축일반시공기능장">건축일반시공기능장</option>						
								  <option value="건축일반시공산업기사">건축일반시공산업기사</option>						
								  <option value="공유압기능사">공유압기능사</option>						
								  <option value="공조냉동기계기능사">공조냉동기계기능사</option>						
								 </select>
								<br>
								
								<div class="d-flex align-items-center justify-content-between mb-4">
										<input type="date" name="res_date" style="width: 100%; height: 50px; text-align: center; font-size: 25px; border-radius: 5px; color: gray; border: none;">
								</div>
										<input type="button" onclick="resCheck()" value="확인" class="btn btn-outline-primary" style="margin-bottom: 5%;">
								
							</form>
								
                        </div>
                    </div>
                    <!-- 시험 예약 end  -->
                    
					<!--  start  -->
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="bg-light text-center rounded p-4">
	                            <div class="d-flex align-items-center justify-content-between mb-4">
	                                <h6 class="mb-0">My Class</h6>
	                            </div>
	                            <table class="table table-striped">
                           		 <%
									if(myCla.size()==0){
										out.println("가입된 class가 없습니다.");
									}else{
								
								%>
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">클래스 이름</th>
                                        <th scope="col">클래스 소개</th>
                                    </tr>
                                </thead>
                                <% } %>
                                <tbody>
                                <%
									if(myCla.size()==0){
									}else{
								
									for(int i = 0; i < myCla.size(); i++){
										classBean b = myCla.get(i);
								%>
                                   <tr>
										<th scope="row">
											<%= i+1 %>
										</th>		
										<td>
											<%= b.getCla_name() %>
										</td>		
										<td>
											<%= b.getCla_intro() %>
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
                    <!-- 예약 확인 end  -->
                    
					<!--  start  -->
	                    
								<div class="col-sm-12 col-md-6 col-xl-4" style="width: 50%;">
			                        <div class="h-100 bg-light rounded p-4">
			                            <div class="d-flex align-items-center justify-content-between mb-4">
			                                <h6 class="mb-0"><i class="bi bi-calendar-date" style="font-size: 1.5rem; color: #389dff;"></i>&nbsp;&nbsp;달력</h6>
			                            </div>
			                            <div id="calender"></div>
			                        </div>
			                    </div>
									
	                      
                    <!--  end  -->
            </div>
            
            <!-- Sales Chart End -->
           
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