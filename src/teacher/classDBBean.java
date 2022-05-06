package teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class classDBBean {
	private static classDBBean instance = new classDBBean();
	public static classDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	public int insertClass(String MEM_ID, String name, String intro, String sub) {
		int re = -1;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int cla_no = 1;
		String sql="";
		
		try {
			conn = getConnection();
			sql = "select max(CLA_NO) from class";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				cla_no = rs.getInt(1)+1;
			}else {
				cla_no = 1;
			}
			
			rs.close();
			ps.close();
			
			conn = getConnection();
			sql = "select CLA_NAME from class where CLA_NAME=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				re = 0;
			}else if (!rs.next()) {
				sql = "insert into class values(?,?,?,?,?,?,?,?)";
				
				ps = conn.prepareStatement(sql);
				ps.setInt(1, cla_no);
				ps.setString(2, name);
				ps.setString(3, intro);
				ps.setString(4, sub);
				ps.setString(5, MEM_ID);
				ps.setInt(6, 2);
				ps.setInt(7, 0);
				ps.setString(8, "bUkvcl8O1Dg");
				re = ps.executeUpdate();
				
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
	
	public ArrayList<String> getTclass(String MEM_ID) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql="";
		ArrayList<String> list = new ArrayList<String>();
		String name="";
		
		try {
			sql = "select CLA_NAME from class where MEMBER_MEM_ID=?";
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, MEM_ID);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				
				name = rs.getString(1);

				list.add(name);
			}
			rs.close();
			ps.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return list;
	}
	public ArrayList<classBean> classMem(String cla_name, String mem_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String sql = "SELECT CLA_NAME, MEMBER_MEM_ID FROM CLASS WHERE CLA_NAME = ? AND MEMBER_MEM_ID != ?";
		ArrayList<classBean> list = new ArrayList<classBean>();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			pstmt.setString(2, mem_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				classBean bean = new classBean();
				bean.setCla_name(rs.getString(1));
				bean.setMember_mem_id(rs.getString(2));
				
				list.add(bean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	
	public int checkPW(String MEM_ID, String MEM_PW) {
		int re = -1;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql="";
		
		
		try {
			sql="select * from member where MEM_ID=? and MEM_PW=?";
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
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();	
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	public int deleteClass(String CLA_NAME) {
		int re = -1;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql="";
		
		
		try {
			sql="delete from question where CLA_NAME=?";
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, CLA_NAME);
			re = ps.executeUpdate();
			
			sql="delete from class where CLA_NAME=?";
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, CLA_NAME);
			re = ps.executeUpdate();
			
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

	public ArrayList<classBean> classList(String mem_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM CLASS WHERE MEMBER_MEM_ID = ?";
		ArrayList<classBean> classList = new ArrayList<classBean>();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				classBean bean = new classBean();
				
				bean.setCla_no(rs.getInt(1));
				bean.setCla_name(rs.getString(2));
				bean.setCla_intro(rs.getString(3));
				bean.setSubject_subject_name(rs.getString(4));
				bean.setMember_mem_id(rs.getString(5));
				bean.setMem_type(rs.getInt(6));
				
				classList.add(bean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return classList;
	}
	
	public classBean getCla(String cla_name) throws Exception {
		classBean bean = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT distinct cla_intro, distict subject_subject_name FROM CLASS WHERE cla_name = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return bean;
	}
	public String getTeaId(String cla_name){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT MEMBER_MEM_ID FROM CLASS WHERE MEM_TYPE = 2 AND CLA_NAME = ?";
		String member_mem_id = "����";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				member_mem_id = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return member_mem_id;
	}
	public ArrayList<classBean> subjectFind(String subject_name){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT C.cla_name, C.cla_intro, C.subject_subject_name, C.member_mem_id FROM CLASS C, MEMBER M WHERE M.MEM_TYPE = 2 AND SUBJECT_SUBJECT_NAME = ? AND C.MEMBER_MEM_ID = M.MEM_ID";	
		
		ArrayList<classBean> list = new ArrayList<classBean>();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, subject_name);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				classBean bean = new classBean();
				
				bean.setCla_name(rs.getString(1));
				bean.setCla_intro(rs.getString(2));
				bean.setSubject_subject_name(rs.getString(3));
				bean.setMember_mem_id(rs.getString(4));
				
				list.add(bean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	public ArrayList<classBean> searchClass(String search){
		ArrayList<classBean> list = new ArrayList<classBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String sql = "SELECT C.cla_name, C.cla_intro, C.subject_subject_name, C.member_mem_id FROM CLASS C, MEMBER M WHERE M.MEM_TYPE = 2  AND C.MEMBER_MEM_ID = M.MEM_ID AND C.CLA_NAME = ? UNION SELECT C.cla_name, C.cla_intro, C.subject_subject_name, C.member_mem_id FROM CLASS C, MEMBER M WHERE M.MEM_TYPE = 2  AND C.MEMBER_MEM_ID = M.MEM_ID AND C.MEMBER_MEM_ID = ?"; 
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				classBean bean = new classBean();
				
				bean.setCla_name(rs.getString(1));
				bean.setCla_intro(rs.getString(2));
				bean.setSubject_subject_name(rs.getString(3));
				bean.setMember_mem_id(rs.getString(4));
				
				list.add(bean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	public int checkMem(String cla_name, String mem_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM CLASS WHERE CLA_NAME = ? AND MEMBER_MEM_ID = ?";
		int re = -1;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			pstmt.setString(2, mem_id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				re = rs.getInt(1);
			}else {
				re = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	public classBean getClass(String tea_id, String cla_name){
		classBean bean = new classBean();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String sql = "SELECT * FROM CLASS WHERE MEMBER_MEM_ID = ? AND CLA_NAME =?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tea_id);
			pstmt.setString(2, cla_name);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				bean.setCla_no(rs.getInt(1));
				bean.setCla_name(rs.getString(2));
				bean.setCla_intro(rs.getString(3));
				bean.setSubject_subject_name(rs.getString(4));
				bean.setMember_mem_id(rs.getString(5));
				bean.setMem_type(3);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return bean;
	}
	public int insertMem(String cla_name, String cla_intro, String subject_name, String mem_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT MAX(CLA_NO) FROM CLASS";
		int cla_no = 0;
		int re = 0;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cla_no = rs.getInt(1)+1;
			}
			rs.close();
			pstmt.close();
			
			sql = "INSERT INTO CLASS VALUES(?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cla_no);
			pstmt.setString(2, cla_name);
			pstmt.setString(3, cla_intro);
			pstmt.setString(4, subject_name);
			pstmt.setString(5, mem_id);
			pstmt.setInt(6, 3);
			pstmt.setInt(7, 0);
			pstmt.setString(8, "u_nc-t4oHfw");
			re = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	public String getSubject(String cla_name){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT DISTINCT SUBJECT_SUBJECT_NAME FROM CLASS WHERE CLA_NAME =?";
		String subject = "";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				subject = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return subject;
	}
	public ArrayList<classBean> getHotName(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="select sum(decode(cla_name,cla_name,1,0)), cla_name from class where mem_type = 2 group by cla_name order by 1 desc";
		ArrayList<classBean> list = new ArrayList<classBean>();
		ArrayList<Integer> sumList = new ArrayList<Integer>();
		int count = 0;
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				if (count == 5) {
					return list;
				}
				classBean bean = new classBean();
				sumList.add(rs.getInt(1));
				bean.setCla_name(rs.getString(2));
				
				list.add(bean);
				count++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	public ArrayList<Integer> getHotSum(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="select sum(decode(cla_name,cla_name,1,0)) from class group by cla_name order by 1 desc";
		ArrayList<Integer> list = new ArrayList<Integer>();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				list.add(rs.getInt(1));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	public void setLink(String cla_name, String re){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "UPDATE CLASS SET LINK = ? WHERE CLA_NAME = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, re);
			pstmt.setString(2, cla_name);
			pstmt.executeUpdate();
			System.out.println(cla_name);
			System.out.println(re);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	public String getLink(String cla_name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT DISTINCT LINK FROM CLASS WHERE CLA_NAME = ?";
		String str = "";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				str = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return str;
	}
	public int getSum(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT DISTINCT count(CLA_NAME) FROM CLASS";
		int count = 0;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return count;
	}
	
	public ArrayList<classBean> getClaMem(String CLA_NAME){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT MEMBER_MEM_ID, CLA_POINT FROM CLASS WHERE CLA_NAME = ? and MEM_TYPE=3 order by CLA_POINT desc";
		ArrayList<classBean> ClaMem = new ArrayList<classBean>();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, CLA_NAME);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				classBean cla = new classBean();
				
				cla.setMember_mem_id(rs.getString(1));
				cla.setCla_point(rs.getInt(2));
				
				ClaMem.add(cla);
			}	
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return ClaMem;
	}
	public void upPoint(String cla_name, String mem_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "UPDATE CLASS SET CLA_POINT = CLA_POINT+1 WHERE CLA_NAME = ? AND MEMBER_MEM_ID = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			pstmt.setString(2, mem_id);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
