<%@page import="member.MemberDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDBBean"%>
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

	if(session.getAttribute("id") == null){
		%>
			<script type="text/javascript">
				alert("로그인 하세요");
				location.href='../main/main.jsp';
			</script>
		<%
	}
	
	BoardDBBean db = BoardDBBean.getInstance(); // listBoard() 메소드 호출 위한 객체 생성
	ArrayList<BoardBean> boardList = db.listBoard(pageNum, 2, sq); // listBoard() 메소드 호출하여 값 가져오기
	Timestamp bo_date;
	int bo_no, bo_hit, mem_no;
	String bo_content, bo_title, mem_id;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	MemberDBBean mdb = MemberDBBean.getInstance();
	String id = session.getAttribute("id").toString();
	int mem_type = mdb.getType(id);
	
	String mem_image = "default_profile.png";
	String type = "Admin";
	if(session.getAttribute("id")!= null){
		mem_id = session.getAttribute("id").toString();
		mem_image = mdb.getMyimg(mem_id);
		mem_type = mdb.getType(mem_id);
		if(mem_type == 2){
			type = "Teacher";
		}else if(mem_type == 3){
			type = "Student";
		}
	}
	
%>
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
    <script type="text/javascript">
    $(function(){
		$(".pop_btn").click(function(){
			var popUrl = "../exam/examMain.jsp";
			var popOption = "width=650px, height = 550px, resizable= no, location=no,top=300px,left=300px";
			window.open("../exam/examMain.jsp","기출문제 풀기","width=650px, height = 550px");
		});
	//	$(".popLogin").click(function(){
	//		window.open("../main/signin.jsp","로그인","width=650px, height = 550px");
	//	});
     }); 
	</script>
<title>Stack Us</title>
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
                        <h6 class="mb-0"><%= id %></h6>
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
                    <a href="../main/main.jsp" class="nav-item nav-link "><i class="bi bi-house-fill me-2"></i>Home</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="bi bi-chat-dots me-2"></i>Community</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="../board/boardlist_0.jsp" class="dropdown-item">공지사항</a>
                            <a href="../board/boardlist_1.jsp" class="dropdown-item ">자유게시판</a>
                            <a href="../board/boardlist_2.jsp" class="dropdown-item active">취득 후기</a>
                            <a href="../board/boardlist_3.jsp" class="dropdown-item">QnA</a>
                        </div>
                    </div>
					<%
                    	if(mem_type== 3){
                    %>
                    <a href="../member/mem_Main.jsp" class="nav-item nav-link"><i class="bi bi-tv-fill me-2"></i>Class</a>
                    <%		
                    	}else{
                    %>
                    <a href="../teacher/class_list.jsp" class="nav-item nav-link"><i class="bi bi-tv-fill me-2"></i>Class</a>
                    <%		
                    	}
                    %>
                    <a href="../main/main.jsp" class="nav-item nav-link pop_btn"><i class="bi bi-ui-checks-grid me-2"></i>CBT</a>
                    <a href="../about/aboutS1.jsp" class="nav-item nav-link"><i class="bi bi-three-dots me-2"></i>About</a>
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
                            <button class="btn btn-outline-primary m-2"><a href="../main/mem_signin.jsp">Login</a></button>
                <%		
                	}
				%>    
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->

			<!-- boardlist -->
			<div class="container-fluid pt-4 px-4">
				<div class="row g-4">
					<div class="col-sm-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h4 class="mb-4">취득 후기 게시판</h4>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-center" style="width: 10%">번호</th>
                                        <th scope="col" style="width: 40%" class="text-center">글제목</th>
                                        <%if(sq==0){%><th scope="col" style="width: 10%" class="text-center"><a href="../board/boardlist_2.jsp?sq=<%=1%>">추천수</a></th><%}%>
                                        <%if(sq==1){%><th scope="col" style="width: 10%" class="text-center"><a href="../board/boardlist_2.jsp?sq=<%=0%>">추천수</a></th><%}%>
                                        <th scope="col" style="width: 10%" class="text-center">조회수</th>
                                        <th scope="col" style="width: 10%" class="text-center">작성자</th>
                                        <th scope="col" style="width: 20%" class="text-center">작성일자</th>
                                    </tr>
                                </thead>
                                <tbody >
                    <%
						for(int i=0; i<boardList.size(); i++){
							BoardBean board = boardList.get(i);
							
							bo_no = board.getBo_no();
							bo_hit = board.getBo_hit();
							bo_content = board.getBo_content();
							bo_title = board.getBo_title();
							mem_id = board.getMem_id();
							bo_date = board.getBo_date();
					%>
                                    <tr onclick="location.href='show.jsp?bo_no=<%= bo_no %>&pageNum=<%= pageNum %>'">
                                        <th scope="row" class="text-center"><%=bo_no%></th>
                                        <td><%=bo_title %></td>
                                        <td class="text-center"><%=db.board_Like_Sum(bo_no)%></td>
                                        <td class="text-center"><%=bo_hit%></td>
                                        <td class="text-center"><%=mem_id %></td>
                                        <td class="text-center"><%=sdf.format(bo_date)%></td>
                                    </tr>
                    <%
						}
					%>
                                </tbody>
                            </table>
                            <div align="right">
                            	<button class="btn btn-outline-secondary" onclick="location.href='../board/write.jsp?bo_type=2'">글쓰기</button>
							</div>
							<div align="center">
								<%= BoardBean.pageNumber(5,"2") %>
							</div>
                        </div>
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