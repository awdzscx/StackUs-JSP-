package comment;

import java.sql.Timestamp;

public class CommentBean {
	private int co_nom;
	private String co_content;
	private Timestamp co_date;
	private int bo_no;
	private String mem_id;
	private int co_ref; 
	private int co_step; 
	private int co_level;
	private int co_r_nom;
	
	public int getCo_r_nom() {
		return co_r_nom;
	}
	public void setCo_r_nom(int co_r_nom) {
		this.co_r_nom = co_r_nom;
	}
	public int getCo_level() {
		return co_level;
	}
	public void setCo_level(int co_level) {
		this.co_level = co_level;
	}
	public int getCo_ref() {
		return co_ref;
	}
	public void setCo_ref(int co_ref) {
		this.co_ref = co_ref;
	}
	public int getCo_step() {
		return co_step;
	}
	public void setCo_step(int co_step) {
		this.co_step = co_step;
	}
	public int getCo_nom() {
		return co_nom;
	}
	public void setCo_nom(int co_nom) {
		this.co_nom = co_nom;
	}
	public String getCo_content() {
		return co_content;
	}
	public void setCo_content(String co_content) {
		this.co_content = co_content;
	}
	public Timestamp getCo_date() {
		return co_date;
	}
	public void setCo_date(Timestamp co_date) {
		this.co_date = co_date;
	}
	public int getBo_no() {
		return bo_no;
	}
	public void setBo_no(int bo_no) {
		this.bo_no = bo_no;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	
	public static int pageSize = 20; //한 페이지당 10개 출력물
	public static int pageCount = 1; //페이지 개수 지정 변수
	public static int pageNum = 1; //페이지 번호
	
	public static String pageNumer(int limit) {
		String str="";
		int temp = (pageNum-1) % limit;
		int startPage=pageNum - temp;
		
		//[이전] 출력
		if ((startPage - limit) > 0) {
			str="<a href='boardlist.jsp?pageNum="+(startPage-1)+"'>[이전]</a>&nbsp;&nbsp;";
		}
		
		//페이지 번호 나열하기
		for (int i = startPage; i < (startPage+limit); i++) {
			if (i == pageNum) {
				str += "["+i+"]&nbsp;&nbsp;";
			} else {
				str += "<a href='boardlist.jsp?pageNum="+i+"'>"+"["+i+"]</a>&nbsp;&nbsp;";
			}
			if(i >= pageCount) break;
		}
		//[다음] 출력
		if ((startPage + limit) <= pageCount) {
			str +="<a href='boardlist.jsp?pageNum="+(startPage+limit)+"'>[다음]</a>";
		}
		
		return str;
	}
}
