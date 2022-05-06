<%@page import="member.MemberDBBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="member" class="member.MemberBean"></jsp:useBean>
<%
	MemberDBBean mb = MemberDBBean.getInstance();
	String mem_id = session.getAttribute("id").toString();
	
	 String path = request.getRealPath("images"); 
	 int maxSize = 1024*1024*10;
	 int fileSize = 0;
	 String file = "";
	 String orifile= "";
	 
	 
	 
	 MultipartRequest multi = new MultipartRequest(request,path,maxSize,"utf-8",new DefaultFileRenamePolicy());
	 Enumeration files = multi.getFileNames();
	 String str = (String)files.nextElement();
	 file = multi.getFilesystemName(str);
	 
	 if(file != null){
		 orifile = multi.getOriginalFileName(str);
		 fileSize = file.getBytes().length;
	 }
	 
	 
	 try{
		 
	 }catch(Exception e){
		 e.printStackTrace();
	 }
	 
	 member.setMEM_IMAGE(file);
	
%>

<%  
	mb.updateImg(member.getMEM_IMAGE(),mem_id); 
%>
	<script type="text/javascript">
		alert("프로필 사진이 변경되었습니다!");
		location.href="../main/MyAccount.jsp";
	</script>
