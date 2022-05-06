package teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class TeacherDBBean {
 
	private static TeacherDBBean instance = new TeacherDBBean();
	public static TeacherDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public String findId(String TEA_NAME, String TEA_EMAIL) {
		String sql = "select TEA_ID from TEACHER where TEA_NAME=? AND TEA_EMAIL=?";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String mid = null;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, TEA_NAME);
			ps.setString(2, TEA_EMAIL);
			
			rs = ps.executeQuery();
			
			if (rs.next()) {
				mid = rs.getString("TEA_ID");
			}

			rs.close();
			ps.close();
			conn.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return mid;
	}
	
	public String findPw(String TEA_ID, String TEA_EMAIL) {
		String pw = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select TEA_PW from TEACHER where TEA_ID=? AND TEA_EMAIL=?";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, TEA_ID);
			ps.setString(2, TEA_EMAIL);
			
			rs = ps.executeQuery();
			
			if (rs.next()) {
				pw = rs.getString("TEA_PW");
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
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return pw;
	}
	
	public int insertTeacher(teacherBean teacher) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int re = -1;
		String sql="";
		int number = 1 ;
		
		try {
			conn = getConnection();
			
			sql="select max(TEA_NO) from TEACHER";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				number = rs.getInt(1)+1;
			}
			
			conn.close();
			ps.close();
			rs.close();
			
			conn = getConnection();
			sql = "insert into teacher(type, tea_no, tea_id, tea_class, tea_pw, tea_name, tea_birth, tea_image, tea_email, tea_tel, subject_subject_name) values(?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, 2);
			ps.setInt(2, number);
			ps.setString(3, teacher.getTEA_ID());
			ps.setInt(4, 0);
			ps.setString(5, teacher.getTEA_PW());
			ps.setString(6, teacher.getTEA_NAME());
			ps.setString(7, teacher.getTEA_BIRTH());
			ps.setString(8, "default_profile.png");
			ps.setString(9, teacher.getTEA_EMAIL());
			ps.setString(10, teacher.getTEA_TEL());
			ps.setString(11, teacher.getSUBJECT_SUBJECT_NAME());
			
			re = ps.executeUpdate();
			
			ps.close();
			conn.close();
			
			System.out.println("입력완료");
			
		} catch (Exception e) {
			System.out.println("입력실패");
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(conn != null) conn.close();
 			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	public int teaLogin(String tea_id, String tea_pw){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT TEA_PW FROM TEACHER WHERE TEA_ID = ? ";
		String db_pwd;
		
		int re = -1;
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tea_id);
			rs = pstmt.executeQuery();
			
 			if(rs.next()) {
 				db_pwd = rs.getString("TEA_PW");
 				
 				if (db_pwd.equals(tea_pw)) {
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
	public int getClass(String tea_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT TEA_CLASS FROM TEACHER WHERE TEA_ID = ? ";
		int class_no = -1;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tea_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				class_no = rs.getInt(1);
			}else {
				class_no = -1;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return class_no;
		
	}
}
