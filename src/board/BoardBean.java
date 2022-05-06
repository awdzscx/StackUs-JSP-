package board;

import java.sql.Timestamp;

public class BoardBean {
	private Timestamp bo_date;	
	private String bo_content;
	private String bo_title;
	private int bo_no;
	private int bo_hit;
	private String mem_id;
	private int bo_type;
	
	public int getBo_type() {
		return bo_type;
	}
	public void setBo_type(int bo_type) {
		this.bo_type = bo_type;
	}
	public Timestamp getBo_date() {
		return bo_date;
	}
	public void setBo_date(Timestamp bo_date) {
		this.bo_date = bo_date;
	}
	public String getBo_content() {
		return bo_content;
	}
	public void setBo_content(String bo_content) {
		this.bo_content = bo_content;
	}
	public String getBo_title() {
		return bo_title;
	}
	public void setBo_title(String bo_title) {
		this.bo_title = bo_title;
	}
	public int getBo_no() {
		return bo_no;
	}
	public void setBo_no(int bo_no) {
		this.bo_no = bo_no;
	}
	public int getBo_hit() {
		return bo_hit;
	}
	public void setBo_hit(int bo_hit) {
		this.bo_hit = bo_hit;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	public static int pageSize = 15; //한 페이지당 10개 출력물
	public static int pageCount = 1; //페이지 개수 지정 변수
	public static int pageNum = 1; //페이지 번호
	
	public static String pageNumber(int limit, String bo_type) {
		String str="<div class=\"btn-group me-2\" role=\"group\" aria-label=\"First group\">";
		int temp = (pageNum-1) % limit;
		int startPage=pageNum - temp;
		
		//[이전] 출력
		if ((startPage - limit) > 0) {
			str +="<button type=\"button\" class=\"btn btn-outline-secondary\" onclick=\"location.href='boardlist_"+bo_type+".jsp?pageNum="+(startPage-1)+"'\">이전</button>";
		}
		
		//페이지 번호 나열하기
		for (int i = startPage; i < (startPage+limit); i++) {
			if (i == pageNum) {
				str += "<button type=\"button\" class=\"btn btn-outline-secondary active\">"+i+"</button>";
			} else {
				str += "<button type=\"button\" class=\"btn btn-outline-secondary\" onclick=\"location.href='boardlist_"+bo_type+".jsp?pageNum="+i+"'\">"+i+"</button>";
			}
			if(i >= pageCount) break;;
		}
		//[다음] 출력
		if ((startPage + limit) <= pageCount) {
			str +="<button type=\"button\" class=\"btn btn-outline-secondary\" onclick=\"location.href='boardlist_"+bo_type+".jsp?pageNum="+(startPage+limit)+"'\">다음</button>";
		}
		
		str += "</div>";
		
		return str;
	}
}
