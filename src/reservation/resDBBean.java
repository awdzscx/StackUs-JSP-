package reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class resDBBean {
	private static resDBBean instance = new resDBBean();
	public static resDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int makeRes(String MEM_ID, String RES_DATE, String EX_NAME) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql ="";
		int re = -1;
		
		try {
			sql = "select * from reservation where MEM_ID=? and EX_NAME=?";
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, MEM_ID);
			ps.setString(2, EX_NAME);
			rs = ps.executeQuery();
			
			if (!rs.next()) {
				sql = "insert into reservation values(?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, EX_NAME);
				ps.setString(2, RES_DATE);
				ps.setString(3, MEM_ID);
				re = ps.executeUpdate();
				
			}else {
				re = 0;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();	
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
}
