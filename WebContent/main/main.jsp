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

		    id0 = setInterval(count0Fn, 5.738853);

		    function count0Fn() {
		      count0++;
		      if (count0 > <%=q_count%>) {
		        clearInterval(id0);
		      } else {
		        $(".number").eq(0).text(count0);
		      }

		    }

		    id1 = setInterval(count1Fn, 5.13171226);

		    function count1Fn() {
		      count1++;
		      if (count1 > <%=c_count%>) {
		        clearInterval(id1);
		      } else {
		        $(".number").eq(1).text(count1);
		      }
		    }

		    id2 = setInterval(count2Fn, 5.57142857);

		    function count2Fn() {
		      count2++;
		      if (count2 > <%=e_count%>) {
		        clearInterval(id2);
		      } else {
		        $(".number").eq(2).text(count2);
		      }
		    }
		    id3 = setInterval(count3Fn, 5.57142857);

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


            <!-- Sale & Revenue Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="bi bi-pencil-square" style="font-size: 3rem; color: #389dff;"></i>
                            <div class="ms-3">
                                <p class="mb-2">전체 문제</p>
                                <h6 class="mb-0 number" style="text-align: right;"><%= q_count %></h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="bi bi-tv-fill" style="font-size: 3rem; color: #389dff;"></i>
                            <div class="ms-3">
                                <p class="mb-2">전체 클래스</p>
                                <h6 class="mb-0 number" style="text-align: right;"><%= c_count %></h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="bi bi-pen-fill" style="font-size: 3rem; color: #389dff;"></i>
                            <div class="ms-3">
                                <p class="mb-2">전체 기출문제</p>
                                <h6 class="mb-0 number" style="text-align: right;"><%= e_count %></h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="bi bi-journal-bookmark-fill" style="font-size: 3rem; color: #389dff;"></i>
                            <div class="ms-3">
                                <p class="mb-2">기출문제 과목</p>
                                <h6 class="mb-0 number" style="text-align: right;">120</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sale & Revenue End -->

            <!-- Widgets Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-md-6">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <h6 class="mb-0"><i class="bi bi-award" style="font-size: 1.5rem; color: #389dff;"></i>&nbsp;인기글</h6>
                                <%if(session.getAttribute("id")!=null){%>
                                <a href="../board/boardlist_1.jsp">Show All</a>
                                <% } %>
                            </div>
                            <% 
                            	for(int i = 0; i<boardList.size(); i++){
                            		BoardBean board = boardList.get(i);
                            		
                            		int bo_no = board.getBo_no();
        							int bo_hit = board.getBo_hit();
        							String bo_content = board.getBo_content();
        							String bo_title = board.getBo_title();
        							String b_mem_id = board.getMem_id();
        							Date bo_date = board.getBo_date();
        							String img =db.getMyimg(b_mem_id);
        							%>
                            <div class="d-flex align-items-center border-bottom py-3">
                            	<img class="rounded-circle flex-shrink-0" src="../images/<%=img%>" alt="" style="width: 40px; height: 40px;">
                                <div class="w-100 ms-3">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h6 class="mb-0"><%=bo_title %></h6>
                                        <small>추천수 : <%=bd.board_Like_Sum(bo_no)%></small>
                                    </div>
                                    <span><%=b_mem_id %></span>
                                </div>
                            </div>
        							<%
                            	}
                            %>

                        </div>
                    </div>
                    <div class="col-sm-12 col-md-6">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                             <h6 class="mb-0"><i class="bi bi-award" style="font-size: 1.5rem; color: #389dff;"></i>&nbsp;인기강의</h6>
                            </div> 
                          <%--   <%
                            	String str = "";
	                            if(request.getParameter("str") != null && !request.getParameter("str").equals("none")){
	                        		str = request.getParameter("str");
	                        		youtube you = new youtube();
	                        		String re = you.youtubeLink(str);
                       		%>--%>
	                            	<iframe width="100%" height="85%" src="https://youtube.com/embed/bUkvcl8O1Dg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                  <%--
	                            	<div>
	                            		<button onclick="location.href='../main/main.jsp?str=none'">링크 다시입력</button>
	                            	</div>
                        		<%
	                        	} else if(request.getParameter("str") == null || request.getParameter("str").equals("none")) {
                       		%>
                        			<form action="../main/main.jsp" method="post">
                        				<input type="text" name="str">
                        			</form>
                       		<%
	                        	}
                            %>
                            --%>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Widgets End -->

            <!-- Sales Chart Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content mb-4">
                                <h6 class="mb-0"><i class="bi bi-alarm"></i>기사 시험일정</h6>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-3">
                                <div class="w-100 ms-3">
                                    <div class="d-flex w-100 justify-content-between">
		                               	<img src="../images/시험일정/정보처리기사.jpg" style="width: 120%">
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content mb-4">
                                <h6 class="mb-0"><i class="bi bi-alarm"></i>기술사 시험일정</h6>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-3">
                                <div class="w-100 ms-3">
                                    <div class="d-flex w-100 justify-content-between">
		                               	<img src="../images/시험일정/에너지관리기사.jpg" style="width: 120%">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content mb-4">
                                <h6 class="mb-0"><i class="bi bi-alarm"></i>기능사 시험일정</h6>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-3">
                                <div class="w-100 ms-3">
                                    <div class="d-flex w-100 justify-content-between">
		                               	<img src="../images/시험일정/화공기사.jpg" style="width: 120%">
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
            <!-- Sales Chart End -->


            <!-- Recent Sales Start -->
        <!--    <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">Recent Salse</h6>
                        <a href="">Show All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col"><input class="form-check-input" type="checkbox"></th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Invoice</th>
                                    <th scope="col">Customer</th>
                                    <th scope="col">Amount</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                    <td>01 Jan 2045</td>
                                    <td>INV-0123</td>
                                    <td>Jhon Doe</td>
                                    <td>$123</td>
                                    <td>Paid</td>
                                    <td><a class="btn btn-sm btn-primary" href="">Detail</a></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                    <td>01 Jan 2045</td>
                                    <td>INV-0123</td>
                                    <td>Jhon Doe</td>
                                    <td>$123</td>
                                    <td>Paid</td>
                                    <td><a class="btn btn-sm btn-primary" href="">Detail</a></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                    <td>01 Jan 2045</td>
                                    <td>INV-0123</td>
                                    <td>Jhon Doe</td>
                                    <td>$123</td>
                                    <td>Paid</td>
                                    <td><a class="btn btn-sm btn-primary" href="">Detail</a></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                    <td>01 Jan 2045</td>
                                    <td>INV-0123</td>
                                    <td>Jhon Doe</td>
                                    <td>$123</td>
                                    <td>Paid</td>
                                    <td><a class="btn btn-sm btn-primary" href="">Detail</a></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                    <td>01 Jan 2045</td>
                                    <td>INV-0123</td>
                                    <td>Jhon Doe</td>
                                    <td>$123</td>
                                    <td>Paid</td>
                                    <td><a class="btn btn-sm btn-primary" href="">Detail</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div> -->
            <!-- Recent Sales End -->

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