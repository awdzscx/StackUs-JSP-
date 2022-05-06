<%@page import="member.MemberDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.awt.color.CMMException"%>
<%@page import="comment.CommentDBBean"%>
<%@page import="comment.CommentBean"%>
<%@page import="board.BoardDBBean"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	String pageNum = request.getParameter("pageNum");
	
	
	//어드민 권한
	String type = session.getAttribute("type").toString();
	
	String s_mem_id = session.getAttribute("id").toString();
	
	// 대댓글 
	int count = 0;
	if(request.getParameter("count") != null){
		count = Integer.parseInt(request.getParameter("count"));
	}
	
	CommentDBBean cm = CommentDBBean.getInstance();
	CommentBean comment2 = cm.getComment(count);
	
	
	// 페이징 
	if(pageNum == null){
		pageNum = "1";
	}
	
	int bno;
	if(request.getParameter("bo_no") != null){
		bno = Integer.parseInt(request.getParameter("bo_no"));
	}else{
		bno = (int)session.getAttribute("bo_no");
	}
	BoardDBBean db = BoardDBBean.getInstance();
	BoardBean board = db.getBoard(bno,true);
	ArrayList<CommentBean> commentList = cm.listComment(bno);
	
	// 추천하기 
	int like_Sum = db.board_Like_Sum(board.getBo_no());
	
	// 글 정보 받아오기
	Timestamp bo_date = null;
	int bo_no=0, bo_hit=0,bo_type=0, mem_no=0, co_ref = 1,co_step = 0,co_level = 0 , co_r_nom = 1;
	String bo_content="",bo_title="",mem_id="",co_mem_id2 = session.getAttribute("id").toString();
	
	if(comment2 != null){
		co_ref = comment2.getCo_ref();
		co_step = comment2.getCo_step();
		co_level = comment2.getCo_level();
	} 
	
	if(board != null){
		bo_date = board.getBo_date(); 
		bo_content = board.getBo_content();
		bo_title = board.getBo_title();
		bo_no = board.getBo_no();
		bo_hit = board.getBo_hit();
		mem_id = board.getMem_id();
		bo_type = board.getBo_type();
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	MemberDBBean mdb = MemberDBBean.getInstance();
	int mem_type = mdb.getType(s_mem_id);
	String mem_image = mdb.getMyimg(mem_id);
	String type1 = "";
	
	if(mem_type == 2){
		type1 = "Teacher";
	}else if(mem_type == 3){
		type = "Student";
	} else if(mem_type ==1) {
		type1 = "Admin";
	}
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Stack Us</title>
<script type="text/javascript">
	function removeCheck() {
	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		location.href='../board/delete_ok.jsp?bo_no=<%= bo_no %>&mem_id=<%= mem_id %>';
	 }else{   //취소
	     return false;
	 }

	}
</script>
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
                        <h6 class="mb-0"><%= s_mem_id%></h6>
                        <span><%= type1 %></span>
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
                            <a href="../board/boardlist_0.jsp" class="dropdown-item active">공지사항</a>
                            <a href="../board/boardlist_1.jsp" class="dropdown-item">자유게시판</a>
                            <a href="../board/boardlist_2.jsp" class="dropdown-item">취득 후기</a>
                            <a href="../board/boardlist_3.jsp" class="dropdown-item">QnA</a>
                        </div>
                    </div>
                    <%
                    	if(type.equals("3")){
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
                            <span class="d-none d-lg-inline-flex"><%= s_mem_id %></span>
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
        
        <div class="container-fluid pt-4 px-4">
        	<div class="row g-4">
        		<div class="col-sm-12">
        			<div class="bg-light rounded h-100 p-4">
        				<form action="../board/comment_ok.jsp?mem_id=<%= co_mem_id2 %>&bo_no=<%=bo_no %>" method="post" name="reg_frm">
							<input type="hidden" name="co_nom" value="<%=count%>">
							<input type="hidden" name="co_ref" value="<%=co_ref%>">
							<input type="hidden" name="co_level" value="<%=co_level%>">
							<input type="hidden" name="co_step" value="<%=co_step%>">
							<input type="hidden" name="co_r_nom" value="<%=co_r_nom%>">		
        				<table class="table caption-top">
        					<caption><h3><%=bo_title %></h4></caption>
        					<thead>
        						<tr>
        							<td width="60%"><i class="bi bi-person-circle"></i>&nbsp;&nbsp;&nbsp;<%=mem_id%></td>
        							<td width="5%">추천 </td>
        							<td width="5%"><%=db.board_Like_Sum(bo_no)%></td>
        							<td width="8%">조회수 </td>
        							<td width="5%"><%=bo_hit%></td>
        							<td width="15%"><%=sdf.format(bo_date)%></td>
        						</tr>
	        					<tr>
	        						<td height="500px" class="align-top" colspan=6">
	        							<br><br><h5><%= bo_content %></h5>
	        						</td>
	        					</tr>
        					</thead>
        					<tbody>
     							<tr>
									<td align="right" colspan="6">
										<div class="btn-group" role="group" aria-label="Basic outlined example">
								<% 
											if(type.equals("admin")){
								%>
											<input type="button" class="btn btn-outline-secondary" value="관리자 글삭제" onclick="removeCheck();">
								<%		
											}else{
												if(session.getAttribute("id").equals(mem_id)){
								%>
												<input type="button" class="btn btn-outline-secondary" value="글수정" onclick="location.href='edit.jsp?bo_no=<%= bo_no %>'">
												<input type="button" class="btn btn-outline-secondary" value="글삭제" onclick="removeCheck()">
								<%
											}
											if(!db.already_Like(board.getBo_no(), s_mem_id)){
								%>
											<input type="button" class="btn btn-outline-secondary" value="추천하기" onclick="location.href='../board/likeOk.jsp?bo_no=<%=bo_no%>&mem_id=<%= s_mem_id %>&already=false'">
								<%
											}else{
								 %>
											<input type="button" class="btn btn-outline-secondary active" value="추천취소" onclick="location.href='../board/likeOk.jsp?bo_no=<%=bo_no%>&mem_id=<%= s_mem_id %>&already=true'">
								<%							
											}
										}
								 %>
										<%if(request.getParameter("s_nom") == null){%><input type="button" class="btn btn-outline-secondary" value="목록으로 " onclick="location.href='../board/boardlist_<%=bo_type%>.jsp?pageNum=<%= pageNum %>'"><%} %>
										<%if(request.getParameter("s_nom") != null){%><input type="button" class="btn btn-outline-secondary" value="목록으로 " onclick="location.href='../board/boardlist_<%=bo_type%>.jsp'"><%} %>
										</div>
									</td>
								</tr>
        					</tbody>
        				</table>
        				<table class="table table-hover">
        					<thead>
        						<tr>
        							<td colspan="5">전체댓글: <%= cm.AllComment(bo_no) %></td>
        						</tr>
        					</thead>
        					<tbody>
        		<%  
					for(int i = 0; i< commentList.size(); i++){
						CommentBean comment = commentList.get(i);
						
						int co_nom = comment.getCo_nom();
						String co_mem_id = comment.getMem_id();
						String co_content = comment.getCo_content();
						Timestamp co_date = comment.getCo_date();
						int co_step2 = comment.getCo_step();
						int co_level2 = comment.getCo_level();
						int co_r_nom2 = comment.getCo_r_nom();
						Boolean delete = false;
						
						if(co_content.equals("삭제된 댓글입니다.") && co_mem_id.equals("admin")){//관리자 id가 들어가야됨
							delete = true;
						} 
						if(delete){//삭제된 경우
							%>
							<tr bgcolor="#dfdfdf">
				   				<td align="center" style="width: 10%"></td>
				   				<td align="center" style="width: 10%"></td>
							<%
						}
						
						if(co_step2 > 0 && !delete){//대댓글인 경우
				%>
							<tr bgcolor="#efefef">
				<%
						} else if(!delete) {//댓글인 경우
				%>
						<tr>
				<%
						}
						if(co_step2 == 0 && !delete){// 댓글
				%>
			   				<td align="center" style="width: 10%"><%= co_r_nom2 %></td>
			   				<td align="center" style="width: 10%"><%= co_mem_id %></td>
				<%
						} else if(!delete && co_step2 != 0) {
	   						if(co_level2 > 0 ){
	   							%>
	   							<td style="width: 10%" class="text-center">
	   							<%
   								for(int j =0; j < co_level2; j++){
				%>
					 			<i class="bi bi-arrow-return-right"></i>
				<%
   								}
	   							%>
   								</td>
	   							<%
   							}
   				%>
			   				<td style="width: 10%" class="text-center"> <%= co_mem_id %></td>
				<%
						}
				%>
							<%
								if(co_step2 > 0){ // 대댓글인경우
									%>
									<td style="width: 50%">
									<%
								} else if(!delete) {// 댓글인 경우
									if(count == co_nom) {
							%>
					   				<td style="width: 50%" onclick="location.href='../board/comment_r_ok.jsp?bo_no=<%=bo_no %>&co_nom=<%=0%>'" >
							<%
									} else{	
							%>
			   						<td style="width: 50%" onclick="location.href='../board/comment_r_ok.jsp?bo_no=<%=bo_no %>&co_nom=<%=co_nom%>'">
							<%
									}
								} else {
							%>
									<td style="width: 50%">
							<%
								}
							%>
			   					&nbsp;<%=co_content %>
			   				</td>
			   				<td width="20%"><%=sdf.format(co_date)%></td> 
			   				<td class="text-right" style="width: 10%">
								<%if(!delete && co_mem_id.equals(s_mem_id) || s_mem_id.equals("admin")){ %>
								<input type="button" class="btn btn-outline-secondary btn-sm" value="삭제" onclick="removeCCheck('<%= co_nom %>')">
								<%} %>
			   				</td>
			   			</tr>
				<%
		   					if(count == co_nom){
 						%>
 							<tr>
 								<td colspan="4" bordercolor="white">
		   							<textarea class="form-control col-sm-5" rows="5" name="co_content" maxlength="120"></textarea>
 								</td>
 							</tr>
 							<tr>
	 							<td align="right" colspan="4">
									<input class="btn btn-outline-secondary"  type="submit" value="대댓글달기" onclick="check_ok()">&nbsp;
									<input class="btn btn-outline-secondary"  type="reset" value="다시작성">
 								</td>
 							</tr>
  						<%
		   					}
					}
				%>
        					</tbody>
        				</table>
									<div align="right">
										<textarea class="form-control col-sm-5" rows="5" name="co_content" maxlength="120"></textarea>
										<br>
										<input class="btn btn-outline-secondary" type="submit" value="댓글달기" onclick="check_ok()">&nbsp; <!-- 자바스크립 check_ok() 넣어야됨 -->
										<input class="btn btn-outline-secondary" type="reset" value="다시작성">
									</div>
        				</form>
        			</div>
        		</div>
        	</div>
        </div>
        								<script type="text/javascript">
								function removeCCheck(i) {
									var mem_id = '<%=s_mem_id%>';
									 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
										if (mem_id == 'admin') {
										 	location.href='../admin/admin_delete_board.jsp?co_nom='+i;
										} else{
											location.href='../board/delete_c_ok.jsp?bo_no=<%=bo_no%>&co_nom='+i+'&mem_id='+mem_id;
										}
									 }else{   //취소
									     return false;
									 }
									}
								</script>
        
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
