package stmp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ReservationDBBean {
	private static ReservationDBBean instance = new ReservationDBBean();
	
	public static ReservationDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public ArrayList<ReservationBean> getResname(String today) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "select distinct MEM_ID from reservation where RES_DATE=?";
		ArrayList<ReservationBean> getRes = new ArrayList<ReservationBean>();
		
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, today);
			
			rs = ps.executeQuery();
			
			while (rs.next()) {
				
				ReservationBean res = new ReservationBean();
				
				res.setRES_NAME(rs.getString(1));
				
				getRes.add(res);
			}
			
			rs.close();
			ps.close();
			conn.close();
			
			
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
		
		return getRes;
	}
	
	public String getEmail(String MEM_ID) {
		String email = "";
		
		String sql = "select MEM_EMAIL from MEMBER where MEM_ID=?";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
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
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();	
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return email;
	}
	
	public int deleteRes(String date) {
		int re=-1;
		
		String sql = "delete from reservation where RES_DATE < = ?";
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, date);
			re = ps.executeUpdate();
			
			System.out.println("�߼ۿϷ�");
			
			ps.close();
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) ps.close();	
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	
}
