<%@page import="stmp.ReservationDBBean"%>
<%@page import="stmp.Mail"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="stmp.ReservationBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ReservationDBBean db = ReservationDBBean.getInstance();

	Mail mail = new Mail();

	Calendar day = Calendar.getInstance();
	day.add(Calendar.DATE, +1);
	String beforeDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(day.getTime());
	
	ArrayList<ReservationBean> myRes = db.getResname(beforeDate);
	
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	
	String time = sf.format(nowTime);
	
	for(int i = 0; i < db.getResname(beforeDate).size(); i++){
		ReservationBean r = myRes.get(i);
		
		mail.sendMail(db.getEmail(r.getRES_NAME()));

	}
	
		db.deleteRes(time);
	
%>

		<script type="text/javascript">
			alert("메일 전송이 완료됐습니다!");
			history.back();
		</script>
