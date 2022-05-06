package member;


public class MemberBean {
	private int MEM_NO;
	private String MEM_ID;
	private String MEM_PW; 
	private String MEM_IMAGE;
	private String MEM_BIRTH;   	
	private String MEM_EMAIL; 
	private String MEM_CONTENT;
	private int MEM_TYPE;
	private String MEM_NAME;
	
	
	
	
	public int getMEM_NO() {
		return MEM_NO;
	}
	public void setMEM_NO(int mEM_NO) {
		MEM_NO = mEM_NO;
	}
	public String getMEM_IMAGE() {
		return MEM_IMAGE;
	}
	public void setMEM_IMAGE(String mEM_IMAGE) {
		MEM_IMAGE = mEM_IMAGE;
	}
	public String getMEM_ID() {
		return MEM_ID;
	}
	public void setMEM_ID(String mEM_ID) {
		MEM_ID = mEM_ID;
	}
	public String getMEM_PW() {
		return MEM_PW;
	}
	public void setMEM_PW(String mEM_PW) {
		MEM_PW = mEM_PW;
	}
	public String getMEM_EMAIL() {
		return MEM_EMAIL;
	}
	public void setMEM_EMAIL(String mEM_EMAIL) {
		MEM_EMAIL = mEM_EMAIL;
	}
	public String getMEM_BIRTH() {
		return MEM_BIRTH;
	}
	public void setMEM_BIRTH(String mEM_BIRTH) {
		MEM_BIRTH = mEM_BIRTH;
	}
	public String getMEM_CONTENT() {
		return MEM_CONTENT;
	}
	public void setMEM_CONTENT(String mEM_CONTENT) {
		MEM_CONTENT = mEM_CONTENT;
	}
	public int getMEM_TYPE() {
		return MEM_TYPE;
	}
	public void setMEM_TYPE(int mEM_TYPE) {
		MEM_TYPE = mEM_TYPE;
	}
	
	public String getMEM_NAME() {
		return MEM_NAME;
	}
	public void setMEM_NAME(String mEM_NAME) {
		MEM_NAME = mEM_NAME;
	}
	

	public static int pageSize = 15; 
	public static int pageCount = 1;
	public static int pageNum = 1;
	
	public static String pageNumber(int limit) {
		String str="<div class=\"btn-group me-2\" role=\"group\" aria-label=\"First group\">";
		int temp = (pageNum-1) % limit;
		int startPage=pageNum - temp;
		
		//[����] ���
		if ((startPage - limit) > 0) {
			str +="<button type=\"button\" class=\"btn btn-outline-secondary\" onclick=\"location.href='memberlist.jsp?pageNum="+(startPage-1)+"'\">이전</button>";
		}
		
		//������ ��ȣ �����ϱ�
		for (int i = startPage; i < (startPage+limit); i++) {
			if (i == pageNum) {
				str += "<button type=\"button\" class=\"btn btn-outline-secondary active\">"+i+"</button>";
			} else {
				str += "<button type=\"button\" class=\"btn btn-outline-secondary\" onclick=\"location.href='memberlist.jsp?pageNum="+i+"'\">"+i+"</button>";
			}
			if(i >= pageCount) break;;
		}
		//[����] ���
		if ((startPage + limit) <= pageCount) {
			str +="<button type=\"button\" class=\"btn btn-outline-secondary\" onclick=\"location.href='memberlist.jsp?pageNum="+(startPage+limit)+"'\">다음</button>";
		}
		
		str += "</div>";
		
		return str;
	}
	
		
}
