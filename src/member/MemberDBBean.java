package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;
import comment.CommentBean;
import my.commentsBean;
import my.likeBean;


public class MemberDBBean {
	
	private static MemberDBBean instance = new MemberDBBean();
	public static MemberDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public String findId(String MEM_NAME, String MEM_EMAIL) {
		String sql = "select MEM_ID from MEMBER where MEM_NAME=? AND MEM_EMAIL=?";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String mid = null;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, MEM_NAME);
			ps.setString(2, MEM_EMAIL);
			
			rs = ps.executeQuery();
			
			if (rs.next()) {
				mid = rs.getString("MEM_ID");
			}

			rs.close();
			ps.close();
			conn.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return mid;
	}
	
	public String findPw(String MEM_ID, String MEM_EMAIL) {
		String pw = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select MEM_PW from MEMBER where MEM_ID=? AND MEM_EMAIL=?";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, MEM_ID);
			ps.setString(2, MEM_EMAIL);
			
			rs = ps.executeQuery();
			
			if (rs.next()) {
				pw = rs.getString("MEM_PW");
			}
			
			rs.close();
			ps.close();
			conn.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return pw;
	}
	
	
	
	public int insertMember(MemberBean member) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int re = -1;
		int mem_no = 1;
		try {
			conn = getConnection();
			String sql = "select max(mem_no) from member";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				mem_no = rs.getInt(1)+1;
			}else {
				mem_no = 1;
			}
			rs.close();
			ps.close();
		
		
		
			sql = "insert into member (mem_no, mem_id, mem_pw, mem_image, mem_birth, mem_email,"
				+ "mem_content, mem_type, mem_tel, mem_name) values(?,?,?,?,?,?,?,?,?,?)";
		
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_no);
			ps.setString(2, member.getMEM_ID());
			ps.setString(3, member.getMEM_PW());
			ps.setString(4, "default_profile.png");
			ps.setString(5, member.getMEM_BIRTH());
			ps.setString(6, member.getMEM_EMAIL());
			ps.setString(7, "반갑습니다. "+member.getMEM_NAME()+"입니다.");
			ps.setInt(8, member.getMEM_TYPE());
			ps.setString(9, "01012341234");
			ps.setString(10, member.getMEM_NAME());
			
			re = ps.executeUpdate();
			

			ps.close();
			conn.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	
	public String getMyimg(String MEM_ID) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select MEM_IMAGE from MEMBER where MEM_ID=?";
		String MEM_IMAGE="";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, MEM_ID);
			
			rs = ps.executeQuery();
			
			if (rs.next()) {
				MEM_IMAGE = rs.getString("MEM_IMAGE");
			}
			
			rs.close();
			ps.close();
			conn.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return MEM_IMAGE;
	}
	
	public String getMyCon(String MEM_ID) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select MEM_CONTENT from MEMBER where MEM_ID=?";
		String con="";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, MEM_ID);
			
			rs = ps.executeQuery();
			
			if (rs.next()) {
				con = rs.getString("MEM_CONTENT");
			}
			
			rs.close();
			ps.close();
			conn.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return con;
	}
	
	public String updateImg(String MEM_IMAGE, String MEM_ID) {
		String fileName = "";

		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			conn = getConnection();
			
			String sql = "update MEMBER set MEM_IMAGE = ? where MEM_ID = ?";
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, MEM_IMAGE);
			ps.setString(2, MEM_ID);
			ps.executeUpdate();
			
			ps.close();
			conn.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			try {
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return fileName;
	}
	public int memLogin(String mem_id, String mem_pw){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT MEM_PW FROM MEMBER WHERE MEM_ID = ? ";
		String db_pwd;
		
		int re = -1;
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			
 			if(rs.next()) {
 				db_pwd = rs.getString("MEM_PW");
 				
 				if (db_pwd.equals(mem_pw)) {
					re=1;
				}else {
					re=0;
				}
 			}else {
 				re=-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	public int addLicense(String mem_id, String license_name, int license_code){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO LICENSE(MEM_ID, LICENSE_NAME, LICENSE_CODE) VALUES(?,?,?)";
		int re = -1;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			pstmt.setString(2, license_name);
			pstmt.setInt(3, license_code);
			pstmt.executeUpdate();
			re = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	public ArrayList<String> licenseList(String mem_id){
		ArrayList<String> licenseList = new ArrayList<String>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String license_name;
		String sql = "SELECT LICENSE_NAME FROM LICENSE WHERE MEM_ID = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				license_name = rs.getString(1);
				
				licenseList.add(license_name);
			}	
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return licenseList;
	}
	public int getType(String mem_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT MEM_TYPE FROM MEMBER WHERE MEM_ID =?";
		int type = 0;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				type = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		 }finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return type;
	}
	  public ArrayList<likeBean> getMyLike(String MEM_ID) {												
		  Connection conn = null; 
		  PreparedStatement ps = null; 
		  ResultSet rs = null;
		  
		  String sql = "select BOARD_BO_NO FROM BOARD_LIKE WHERE MEMBER_MEM_ID = ?"; 
		  ArrayList<likeBean> myLike = new ArrayList<likeBean>();
		  
		  try { 
		  conn = getConnection(); 
		  ps = conn.prepareStatement(sql);
		  ps.setString(1, MEM_ID);
		  
		  
		  rs = ps.executeQuery();
		  
		  while (rs.next()) { 
			  
		  likeBean like = new likeBean();
		  
		  like.setBOARD_BO_NO(rs.getInt(1));
		  
		  myLike.add(like);
			  
		  }
		  
		  rs.close(); 
		  ps.close(); 
		  conn.close();
		  
		  }catch (Exception e) { 
			  e.printStackTrace(); 
		  } finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		  
		  return myLike; 
		  }
	
	  public String getLikeBoardName(int BOARD_BO_NO) {								
		  String bn = "";
		  Connection conn = null;
		  PreparedStatement ps = null;
		  ResultSet rs = null;
		  
		  String sql = "select BO_TITLE from BOARD where BO_NO=?";
		  
		  try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, BOARD_BO_NO);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				bn = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		  return bn;
	  }
	  
	  public ArrayList<CommentBean> getMyreply(String MEM_ID) {								
		  Connection conn = null; 
		  PreparedStatement ps = null; 
		  ResultSet rs = null;
		  
		  String sql = "select CO_CONTENT, CO_DATE, CO_NOM FROM COMMENTS WHERE MEMBER_MEM_ID = ? order by co_nom desc"; 
		  ArrayList<CommentBean> myCom = new ArrayList<CommentBean>();
		  
		  try { 
		  conn = getConnection(); 
		  ps = conn.prepareStatement(sql);
		  ps.setString(1, MEM_ID);
		  
		  rs = ps.executeQuery();
		  
		  while (rs.next()) { 
			  
		  CommentBean db = new CommentBean();
		  
		  db.setCo_content(rs.getString(1));
		  db.setCo_date(rs.getTimestamp(2));
		  db.setCo_nom(rs.getInt(3));
		  
		  myCom.add(db);
			  
		  }
		  
		  rs.close(); 
		  ps.close(); 
		  conn.close();
		  
		  }catch (Exception e) { 
			  e.printStackTrace(); 
		  }finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			} 
		  return 
				  myCom; 
		  }
	  
	  public ArrayList<BoardBean> getMyWrite(String MEM_ID) {										
		  Connection conn = null; 
		  PreparedStatement ps = null; 
		  ResultSet rs = null;
		  
		  String sql = "select BO_CONTENT, BO_TITLE, BO_DATE FROM BOARD WHERE MEMBER_MEM_ID =? order by BO_NO desc";
		  ArrayList<BoardBean> content = new ArrayList<BoardBean>();
		  
		  try { 
			  conn = getConnection(); 
			  ps = conn.prepareStatement(sql);
			  ps.setString(1, MEM_ID);
		  
		  
			  rs = ps.executeQuery();
		  
			  while (rs.next()) { 
			
			  BoardBean db = new BoardBean();
			  
			  db.setBo_content(rs.getString(1));
			  db.setBo_title(rs.getString(2));
			  db.setBo_date(rs.getTimestamp(3));
			  
			  content.add(db); 
			  
			  }
		  
			  rs.close(); 
			  ps.close(); 
			  conn.close();
		  
		  		}catch (Exception e){
		  			e.printStackTrace(); 
		  	
		  		}finally {
					try {
						if(rs != null) rs.close();
						if(ps != null) ps.close();
						if(conn != null) conn.close();
					} catch (Exception e2) {
						e2.printStackTrace();
					}
				} 
		  return content; 
		  	}
		public int updateMember(String MEM_ID, String MEM_PW, String MEM_EMAIL, String MEM_BIRTH, String MEM_TEL, int MEM_TYPE) {
			int re= -1;
			Connection conn = null; 
			 PreparedStatement ps = null; 

			String sql="update MEMBER set MEM_EMAIL=?, MEM_BIRTH=?, MEM_TEL=?, MEM_TYPE=? where MEM_ID = ? and MEM_PW=?";
			 
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_EMAIL);
				ps.setString(2, MEM_BIRTH);
				ps.setString(3, MEM_TEL);
				ps.setInt(4, MEM_TYPE);
				ps.setString(5, MEM_ID);
				ps.setString(6, MEM_PW);
				re=ps.executeUpdate();
				
				ps.close(); 
				conn.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			 return re;
		}
		public String getMyName(String MEM_ID) {
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "select MEM_NAME from MEMBER where MEM_ID=?";
			String name="";
			
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				
				rs = ps.executeQuery();
				
				if (rs.next()) {
					name = rs.getString(1);
				}
				
				rs.close();
				ps.close();
				conn.close();
				
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				}catch(Exception e2) {
					e2.printStackTrace();
				}
			}
			return name;
		}	
		
		public int pwCheck(String MEM_ID, String MEM_PW) {
			int re = -1;
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "select * from member where MEM_ID =? and MEM_PW=?";
			
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				ps.setString(2, MEM_PW);
				rs = ps.executeQuery();
				
				if (rs.next()) {
					re = 1;
				}else {
					re = 0;
				}
				
				rs.close();
				ps.close();
				conn.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			
			return re;
		}
		
		public int deleteMember(String MEM_ID) {
			int re = -1;
			
			Connection conn = null;
			PreparedStatement ps = null;
			String sql = "";
			
			try {
				
				sql = "delete from BOARD_LIKE where MEMBER_MEM_ID =?";
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				re = ps.executeUpdate();
				ps.close();
				
				sql = "delete from COMMENTS where MEMBER_MEM_ID =?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				re = ps.executeUpdate();
				ps.close();
				
				sql = "delete from BOARD where MEMBER_MEM_ID =?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				re = ps.executeUpdate();
				ps.close();
				
				sql = "delete from CLASS where MEMBER_MEM_ID =?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				re = ps.executeUpdate();
				ps.close();
				
				
				sql = "delete from LICENSE where MEM_ID =?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				re = ps.executeUpdate();
				ps.close();
				
				sql = "delete from RESERVATION where MEM_ID =?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				re = ps.executeUpdate();
				ps.close();

				sql = "delete from RESULT where MEM_ID =?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				re = ps.executeUpdate();
				ps.close();

				sql = "delete from MEMBER where MEM_ID =?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				re = ps.executeUpdate();
				
				ps.close();
				conn.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return re;
		}
		
		public int updateMember(String MEM_ID, String MEM_PW, String MEM_EMAIL, String MEM_BIRTH, String MEM_TEL, int MEM_TYPE, String MEM_CONTENT) {
			int re = -1;
			Connection conn = null;
			PreparedStatement ps = null;
			String sql = "update member set MEM_EMAIL=?, MEM_BIRTH=?, MEM_TEL=?, MEM_TYPE=?, MEM_CONTENT=? where MEM_ID=? and MEM_PW=?";
			
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_EMAIL);
				ps.setString(2, MEM_BIRTH);
				ps.setString(3, MEM_TEL);
				ps.setInt(4, MEM_TYPE);
				ps.setString(5, MEM_CONTENT);
				ps.setString(6, MEM_ID);
				ps.setString(7, MEM_PW);
				re = ps.executeUpdate();
				
				ps.close();
				conn.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return re;
		}
		public String getContent(String mem_id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "SELECT MEM_CONTENT FROM MEMBER WHERE MEM_ID = ?";
			String content="";
			
			try {
				con = getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mem_id);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					content = rs.getString(1);			}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(con != null) con.close();
				}catch(Exception e2) {
					e2.printStackTrace();
				}finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(con != null) con.close();
					} catch (Exception e2) {
						e2.printStackTrace();
					}
				}
			}
			return content;
		}
		

		public Date getmybirth(String MEM_ID) {
			Date birth = null;
			
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "select MEM_BIRTH from member where MEM_ID=?";
			
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				rs = ps.executeQuery();
				
				if (rs.next()) {
					birth = rs.getDate(1);
				}
				
				rs.close();
				ps.close();
				conn.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return birth;
		}
		
		public int checkLicense(String MEM_ID, String EX_NAME) {
			int re=-1;
			
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "select * from license where MEM_ID=? and LICENSE_NAME=?";
			
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				ps.setString(2, EX_NAME);
				rs = ps.executeQuery();
				
				if (!rs.next()) {
					re=1;
				}
				
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return re;
		}
		
		public String getmyemail(String MEM_ID) {
			String email = null;
			
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "select MEM_EMAIL from member where MEM_ID=?";
			
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				rs = ps.executeQuery();
				
				if (rs.next()) {
					email = rs.getString(1);
				}
				
				rs.close();
				ps.close();
				conn.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			 
			return email;
		}
		
		public int exitClass(String MEM_ID,String CLA_NAME) {
			int re= -1;
			
			Connection conn = null;
			PreparedStatement ps = null;
			
			String sql = "delete from class where MEMBER_MEM_ID=? and CLA_NAME=?";
			
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				ps.setString(2, CLA_NAME);
				re = ps.executeUpdate();
				
				ps.close();
				conn.close();
				
			} catch (Exception e) {
				re=0;
				e.printStackTrace();
			} finally {
				try {
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			 
			return re;
		}
			
		public int exitClass(String MEM_ID) {
			int re= -1;
			
			Connection conn = null;
			PreparedStatement ps = null;
			
			String sql = "delete from class where MEMBER_MEM_ID=?";
			
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, MEM_ID);
				re = ps.executeUpdate();
				
				ps.close();
				conn.close();
				
			} catch (Exception e) {
				re=0;
				e.printStackTrace();
			} finally {
				try {
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			 
			return re;
		}
			
		
		public int getBoNo(String title, String content, Timestamp date) {
			int re = -1;
			
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "select BO_NO from BOARD where BO_TITLE=? and BO_CONTENT=? and BO_DATE=?";
			
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, title);
				ps.setString(2, content);
				ps.setTimestamp(3, date);
				rs = ps.executeQuery();
				
				if(rs.next()) {
					re = rs.getInt(1);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return re;
		}
		
		public int getCBoNo(int nom, String content, Timestamp date) {
			int re = -1;
			
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "select BOARD_BO_NO from COMMENTS where CO_NOM=? and CO_CONTENT=? and CO_DATE=?";
			
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setInt(1, nom);
				ps.setString(2, content);
				ps.setTimestamp(3, date);
				rs = ps.executeQuery();
				
				if(rs.next()) {
					re = rs.getInt(1);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return re;
		}
		
		public ArrayList<BoardBean> searchTitle(String title){
			Connection con=null;
			Statement st=null;
			ResultSet rs=null;
			
			ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
			
			try {
				con = getConnection();
				st = con.createStatement();
				String sql = "SELECT * FROM BOARD where BO_TITLE like '%"+title+"%'";
				rs = st.executeQuery(sql);
				
				
				while (rs.next()) {
						BoardBean board = new BoardBean();	 				
						board.setBo_date(rs.getTimestamp("bo_date"));
						board.setBo_content(rs.getString("bo_content"));
						board.setBo_title(rs.getString("bo_title"));
						board.setBo_no(rs.getInt("bo_no"));
						board.setBo_hit(rs.getInt("bo_hit"));
						board.setMem_id(rs.getString("member_mem_id"));
						board.setBo_type(rs.getInt("BO_TYPE"));
						
		 				boardList.add(board);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(rs != null) rs.close();
					if(st != null) st.close();
					if(con != null) con.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return boardList;
		}
		public ArrayList<BoardBean> searchWriter(String Writer){
			Connection con=null;
			Statement st=null;
			ResultSet rs=null;
			
			ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
			
			try {
				con = getConnection();
				st = con.createStatement();
				String sql = "SELECT * FROM BOARD where MEMBER_MEM_ID like '%"+Writer+"%'";
				rs = st.executeQuery(sql);
				
				
				while (rs.next()) {
					BoardBean board = new BoardBean();	 				
					board.setBo_date(rs.getTimestamp("bo_date"));
					board.setBo_content(rs.getString("bo_content"));
					board.setBo_title(rs.getString("bo_title"));
					board.setBo_no(rs.getInt("bo_no"));
					board.setBo_hit(rs.getInt("bo_hit"));
					board.setMem_id(rs.getString("member_mem_id"));
					board.setBo_type(rs.getInt("BO_TYPE"));
					
					boardList.add(board);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(rs != null) rs.close();
					if(st != null) st.close();
					if(con != null) con.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return boardList;
		}
		public ArrayList<BoardBean> searchContent(String Content){
			Connection con=null;
			Statement st=null;
			ResultSet rs=null;
			
			ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
			
			try {
				con = getConnection();
				st = con.createStatement();
				String sql = "SELECT * FROM BOARD where BO_CONTENT like '%"+Content+"%'";
				rs = st.executeQuery(sql);
				
				
				while (rs.next()) {
					BoardBean board = new BoardBean();	 				
					board.setBo_date(rs.getTimestamp("bo_date"));
					board.setBo_content(rs.getString("bo_content"));
					board.setBo_title(rs.getString("bo_title"));
					board.setBo_no(rs.getInt("bo_no"));
					board.setBo_hit(rs.getInt("bo_hit"));
					board.setMem_id(rs.getString("member_mem_id"));
					board.setBo_type(rs.getInt("BO_TYPE"));
					
					boardList.add(board);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(rs != null) rs.close();
					if(st != null) st.close();
					if(con != null) con.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return boardList;
		}
		
		public ArrayList<MemberBean> listmember(String pageNumber,int mem_type, int sq){
			Connection con=null;
			Statement stmt=null;
			ResultSet rs=null;
			ResultSet pageSet=null;
			
			int dbCount=0;
			int absolutePage=1;
			
			ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
			
			try {
				con = getConnection();
				stmt = con.createStatement();
				String sql = "SELECT COUNT(MEM_NO) FROM MEMBER where mem_type !="+mem_type;
				pageSet = stmt.executeQuery(sql);
				
				if (pageSet.next()) {
					dbCount = pageSet.getInt(1);
					pageSet.close();
					stmt.close();
				}
				
				if (dbCount % MemberBean.pageSize == 0) {	//80
					MemberBean.pageCount = dbCount / MemberBean.pageSize;
				} else {	//84
					MemberBean.pageCount = dbCount / MemberBean.pageSize + 1;
				}
				
				if (pageNumber != null) {
					MemberBean.pageNum = Integer.parseInt(pageNumber);
					//1: 0*10+1=1, 2: 1*10+1=11
					absolutePage = (MemberBean.pageNum - 1) * MemberBean.pageSize + 1;
				}
				
				//stmt = conn.createStatement();
				stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				if (sq == 1) {
					sql = "select MEM_NO, MEM_ID, MEM_BIRTH, MEM_EMAIL, MEM_TYPE, MEM_NAME from member where mem_type != "+mem_type+" order by MEM_NO desc";
				}  else {
					sql = "SELECT MEM_NO, MEM_ID, MEM_BIRTH, MEM_EMAIL, MEM_TYPE, MEM_NAME FROM MEMBER WHERE MEM_TYPE !="+mem_type+" ORDER BY MEM_NO DESC";
				}
				rs = stmt.executeQuery(sql);
	 			
	 			if (rs.next()) {
					rs.absolute(absolutePage);
					int count = 0;
					
		 			while (count < MemberBean.pageSize) {
		 				MemberBean mem = new MemberBean();
		 				
		 				mem.setMEM_NO(rs.getInt(1));
		 				mem.setMEM_ID(rs.getString(2));
		 				mem.setMEM_BIRTH(rs.getString(3));
		 				mem.setMEM_EMAIL(rs.getString(4));
		 				mem.setMEM_TYPE(rs.getInt(5));
		 				mem.setMEM_NAME(rs.getString(5));
						
		 				memberList.add(mem);
		 				
		 				if (rs.isLast()) {
							break;
						} else {
							rs.next();
						}
		 				
		 				count++;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(rs != null) rs.close();
					if(stmt != null) stmt.close();
					if(con != null) con.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return memberList;
		}
		
}
