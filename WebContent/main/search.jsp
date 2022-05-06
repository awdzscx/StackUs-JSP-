<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.logging.SimpleFormatter"%>
<%@page import="exam.examDBBean"%>
<%@page import="teacher.classDBBean"%>
<%@page import="question.questionDBBean"%>
<%@page import="youtube.youtube"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDBBean"%>
<%@page import="board.BoardBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	if(session.getAttribute("cr") != null) session.removeAttribute("cr");

	BoardDBBean bd = BoardDBBean.getInstance(); // listBoard() 메소드 호출 위한 객체 생성
	ArrayList<BoardBean> boardList = bd.listBoardP(); // listBoard() 메소드 호출하여 값 가져오기
%>
<%
	questionDBBean qdb = questionDBBean.getInstance();
	int q_count = qdb.getSum();
	classDBBean cdb = classDBBean.getInstance();
	int c_count = cdb.getSum();
	examDBBean edb = examDBBean.getInstance();
	int e_count = edb.getSum();
	
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
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
    $(function(){
		$(".pop_btn").click(function(){
			window.open("../exam/examMain.jsp","기출문제 풀기","width=800px, height = 550px");
		});
     }); 
	</script>
	<script type="text/javascript" src="../js/countUp.js"></script>
	<script type="text/javascript">
	$(function() {
		  var count0 = count1 = count2= count3 = 0;

		  timeCounter();

		  function timeCounter() {

		    id0 = setInterval(count0Fn, 12.738853);

		    function count0Fn() {
		      count0++;
		      if (count0 > <%=q_count%>) {
		        clearInterval(id0);
		      } else {
		        $(".number").eq(0).text(count0);
		      }

		    }

		    id1 = setInterval(count1Fn, 10.13171226);

		    function count1Fn() {
		      count1++;
		      if (count1 > <%= c_count%>) {
		        clearInterval(id1);
		      } else {
		        $(".number").eq(1).text(count1);
		      }
		    }

		    id2 = setInterval(count2Fn, 28.57142857);

		    function count2Fn() {
		      count2++;
		      if (count2 > <%= e_count%>) {
		        clearInterval(id2);
		      } else {
		        $(".number").eq(2).text(count2);
		      }
		    }
		    id3 = setInterval(count3Fn, 28.57142857);

		    function count3Fn() {
		      count3++;
		      if (count3 > 120) {
		        clearInterval(id3);
		      } else {
		        $(".number").eq(3).text(count3);
		      }
		    }
		  }
		});
	</script>
</head>

<body>
	<%
		String mem_image = "default_profile.png";
		String mem_id = "";
		int mem_type = 1;
		String type = "Admin";
		MemberDBBean db = MemberDBBean.getInstance();
		if(session.getAttribute("id")!= null){
			mem_id = session.getAttribute("id").toString();
			mem_image = db.getMyimg(mem_id);
			mem_type = db.getType(mem_id);
			if(mem_type == 2){
				type = "Teacher";
			}else if(mem_type == 3){
				type = "Student";
			}
		}
		
	%>
    <div class="container-xxl position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Sidebar Start -->
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
                        <img class="rounded-circle" src="../images/<%= mem_image %>" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0"><%= mem_id %></h6>
                        <span><%= type %></span>
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
                    <a href="../main/main.jsp" class="nav-item nav-link active"><i class="bi bi-house-fill me-2"></i>Home</a>
             	  <% 
                  	if(session.getAttribute("id")!= null){
               	  %>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="bi bi-chat-dots me-2"></i>Community</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="../board/boardlist_0.jsp" class="dropdown-item">공지사항</a>
                            <a href="../board/boardlist_1.jsp" class="dropdown-item">자유게시판</a>
                            <a href="../board/boardlist_2.jsp" class="dropdown-item">취득 후기</a>
                            <a href="../board/boardlist_3.jsp" class="dropdown-item">QnA</a>
                        </div>
                    </div>
                  <% } %>
                    <%
                    	if(mem_type==3){
                    %>
	                    <a href="../member/mem_Main.jsp" class="nav-item nav-link"><i class="bi bi-tv-fill me-2"></i>Class</a>
                    <%		
                    	}else{
                    %>
	                    <a href="../teacher/class_list.jsp" class="nav-item nav-link"><i class="bi bi-tv-fill me-2"></i>Class</a>
                    <%		
                    	}
                    %>
	                <% 
	                  	if(session.getAttribute("id")!= null){
	               	%>
                    <a href="../main/main.jsp" class="nav-item nav-link pop_btn"><i class="bi bi-ui-checks-grid me-2"></i>CBT</a>
                    <% } %>
                    <a href="../about/aboutS1.jsp" class="nav-item nav-link"><i class="bi bi-three-dots me-2"></i>About</a>
                    <%
                    	if(mem_type == 1 && session.getAttribute("id")!=null){
                    %>		
                    <a href="../main/admin_page.jsp" class="nav-item nav-link"><i class="bi bi-card-list me-2"></i>Manage</a>
                    <%
                    	}
                    %>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="bi bi-shield-lock me-2"></i>Account</a>
                        <div class="dropdown-menu bg-transparent border-0">
                        <%
                        	if(session.getAttribute("id")!=null){
                        %>
                            <a href="../main/MyAccount.jsp" class="dropdown-item">My Page</a>
                            <a href="../main/logout.jsp" class="dropdown-item">Logout</a>
                        <%		
                        	}else{
                        %>
                            <a href="../main/mem_signin.jsp" class="dropdown-item">Sign In</a>
                            <a href="../main/mem_signup.jsp" class="dropdown-item">Sign Up</a>
                        <%	
                        	}
                        %>
                        </div>
                    </div>
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
                            <img class="rounded-circle me-lg-2" src="../images/<%= mem_image %>" alt="" style="width: 40px; height: 40px;">
                            <span class="d-none d-lg-inline-flex"><%= mem_id %></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="../main/MyAccount.jsp" class="dropdown-item">마이페이지</a>
                            <a href="../main/mem_edit.jsp" class="dropdown-item">수정하기</a>
                            <a href="../main/logout.jsp?href=../main/main.jsp" class="dropdown-item">로그아웃</a>
                        </div>
                <%
                	}else{
                %>
                            <button class="btn btn-outline-primary m-2"><a href="../main/mem_signin.jsp">Login</a></button>
                <%		
                	}
				%>    
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->
			<%
				String selbox = request.getParameter("selbox");
				String searchcon = request.getParameter("search");
				ArrayList<BoardBean> search = new ArrayList();
				
				SimpleDateFormat frm = new SimpleDateFormat("yyyy-MM-dd");
				
				if(selbox.equals("제목")){
					search = db.searchTitle(searchcon);
				}else if(selbox.equals("작성자")){
					search = db.searchWriter(searchcon);
				}else if(selbox.equals("내용")){
					search = db.searchContent(searchcon);
				}
			%>

         	<div class="container-fluid pt-4 px-4" style="font-family: 'NanumSquare', sans-serif;">
                <div class="row g-4">
                    <div class="col-sm-12 col-xl-6" style="width: 80%;">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4" style="font-size: 30px;">
                            	검색 결과
                            </div>
                            <table class="table table-striped">
                            	<%
									if(search.size()==0){
										out.println("검색 결과가 없습니다.");
									}else{
								
								%>
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">제목</th>
                                        <th scope="col">작성자</th>
                                        <th scope="col">내용</th>
                                        <th scope="col">날짜</th>
                                    </tr>
                                </thead>
                                <% } %>
                                <tbody>
                                <%
									if(search.size()==0){
									}else{
									
									for(int i = 0; i < search.size(); i++){
										BoardBean board = search.get(i);
								%>
                                   <tr>
										<th scope="row">
											<%= i+1 %>
										</th>		
										<td>
											<% if(session.getAttribute("id")!=null){
												%>
											<a href="http://localhost:8484/stackus/board/show.jsp?bo_no=<%=db.getBoNo(board.getBo_title(), board.getBo_content(), board.getBo_date()) %>"><%= board.getBo_title() %></a>
												<%
											}else{
												out.println(board.getBo_title());
											}
												%>
											
										</td>	
										<td>
											<%= board.getMem_id() %>
										</td>	
										<td>
											<%= board.getBo_content() %>
										</td>	
										<td>
											<%= frm.format(board.getBo_date()) %>
										</td>		
									</tr>
									<%}} %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
            </div>

            <!-- Footer Start -->
            <div class="container-fluid bg-white pt-5 px-3">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">StackUs</a>, All Right Reserved. 
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