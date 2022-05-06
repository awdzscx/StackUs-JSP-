package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class adminDBBean {
	private static adminDBBean instance = new adminDBBean();
	public static adminDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	public int deleteBoard(int BO_NO) {
		int re = -1;
		String sql = "";
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			sql = "delete from BOARD_LIKE where BOARD_BO_NO = ?";
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, BO_NO);
			ps.executeUpdate();
			ps.close();
			
			sql = "delete from COMMENTS where BOARD_BO_NO = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, BO_NO);
			ps.executeUpdate();
			ps.close();
			
			sql = "delete from BOARD where BO_NO = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, BO_NO);
			
			re = ps.executeUpdate();
			
			ps.close();
			conn.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(conn!=null) conn.close();
				if(ps!=null) ps.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
		return re;
	}
	public void changeLink(String link){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "UPDATE MAIN SET LINK = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, link);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	public String getLink(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select link from main";
		String link = "";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				link = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return link;
	}
}
