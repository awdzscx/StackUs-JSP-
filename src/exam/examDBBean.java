package exam;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class examDBBean {
	private static examDBBean instance = new examDBBean();
	
	public static examDBBean getInstance() {
		return instance;
	}
	
	public static Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public ArrayList<exambean> getExam(String ex_object1, String ex_object2, int ex_code) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<exambean> list = new ArrayList<exambean>();
		String sql = "SELECT EX_NO, EX_CONTENT, EX_IMAGE, EX_FIRST, EX_SECOND, EX_THIRD, EX_FOURTH,"
				+ "EX_FIFTH, EX_RIGHT, EX_COMMENT, EX_CORRECT, EX_INCORRECT FROM EXAM WHERE EX_OBJECT1"
				+ "= ? AND EX_OBJECT2 =? AND EX_CODE = ? ORDER BY EX_NO";
		try {
			con = getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, ex_object1);
			ps.setString(2, ex_object2);
			ps.setInt(3, ex_code);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				exambean bean = new exambean();
				bean.setEx_no(rs.getInt(1));
				bean.setEx_content(rs.getString(2));
				bean.setEx_image(rs.getString(3));
				bean.setEx_first(rs.getNString(4));
				bean.setEx_second(rs.getNString(5));
				bean.setEx_third(rs.getNString(6));
				bean.setEx_fourth(rs.getNString(7));
				bean.setEx_fifth(rs.getNString(8));
				bean.setEx_right(rs.getInt(9));
				bean.setEx_comment(rs.getString(10));
				bean.setEx_correct(rs.getInt(11));
				bean.setEx_incorrect(rs.getInt(12));
				
				list.add(bean);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}	
		return list;
	}
	public ArrayList<String> getObject1(){
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<String> list = new ArrayList<String>();
		String sql = "SELECT DISTINCT EX_OBJECT1 FROM EXAM ORDER BY 1";
		
		try {
			con = getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				list.add(rs.getString(1));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}	
		return list;
	}
	public ArrayList<String> getObject2(String ex_object1){
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<String> list = new ArrayList<String>();
		String sql = "SELECT DISTINCT EX_OBJECT2 FROM EXAM WHERE EX_OBJECT1 = ? ORDER BY 1";
		
		try {
			con = getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, ex_object1);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				list.add(rs.getString(1));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}	
		return list;
	}
	public ArrayList<Integer> getCode(String ex_object1, String ex_object2){
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Integer> list = new ArrayList<Integer>();
		String sql = "SELECT DISTINCT EX_CODE FROM EXAM WHERE EX_OBJECT1= ? AND EX_OBJECT2 =? ORDER BY 1";
		
		try {
			con = getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, ex_object1);
			ps.setString(2, ex_object2);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				list.add(rs.getInt(1));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	public int getPercent(String ex_object2, int ex_code, int ex_no){
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT EX_CORRECT, EX_INCORRECT FROM EXAM WHERE EX_OBJECT2= ? AND"
				+ "EX_CODE = ? AND EX_NO =?";
		int correct = 1;
		int incorrect = 1;
		int re = -1;
		try {
			con = getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, ex_object2);
			ps.setInt(2, ex_code);
			ps.setInt(3, ex_no);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				correct = rs.getInt(1);
				incorrect = rs.getInt(2);
				if (correct+incorrect!=0) {
					re = correct*100/correct+incorrect;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	public String getDab(String ex_object2, int ex_code){
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT EX_RIGHT FROM EXAM WHERE EX_OBJECT2 = ? AND EX_CODE = ? ORDER BY 1";
		String dab="";
		
		try {
			con = getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, ex_object2);
			ps.setInt(2, ex_code);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				dab+= rs.getNString(1)+"/";
			}
			

			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return dab;
	}
	public void correctUpdate(int fnum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "UPDATE EXAM SET EX_CORRECT = EX_CORRECT+1 WHERE EX_FNUM = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fnum);
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
	
	public void incorrectUpdate(int fnum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "UPDATE EXAM SET EX_INCORRECT = EX_INCORRECT+1 WHERE EX_FNUM = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fnum);
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
	public int getSum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM EXAM";
		int sum = 0;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sum = rs.getInt(1);
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
		return sum;
	}
	public int getEx_sum(String ex_object2, int ex_code){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM EXAM WHERE EX_OBJECT2 =? AND EX_CODE = ?";
		int sum = 0;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ex_object2);
			pstmt.setInt(2, ex_code);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sum = rs.getInt(1);
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
		return sum;
	}
	public int getRight(String ex_object2, int ex_code, int ex_no){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT EX_RIGHT FROM EXAM WHERE EX_OBJECT2 =? AND EX_CODE = ? AND EX_NO = ?";
		int right = 0;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ex_object2);
			pstmt.setInt(2, ex_code);
			pstmt.setInt(3, ex_no);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				right = rs.getInt(1);
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
		return right;
	}
	public int exsum(String ex_object1, String ex_object2, int ex_code){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from exam where ex_object1=? and ex_object2=? and ex_code =?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ex_object1);
			pstmt.setString(2, ex_object2);
			pstmt.setInt(3, ex_code);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1);
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
		return 0;
	}
	public ArrayList<exambean> myresult(String mem_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT SCORE, EX_OBJECT2, EX_CODE FROM RESULT WHERE MEM_ID = ? ORDER BY RES_NO";
		ArrayList<exambean> list = new ArrayList<exambean>();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				exambean bean = new exambean();
				bean.setScore(rs.getInt(1));
				bean.setEx_object2(rs.getString(2));
				bean.setEx_code(rs.getInt(3));
				
				list.add(bean);
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
		return list;
	}
	public void insertResult(int score, String ex_object2, int ex_code, String mem_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT MAX(RES_NO) FROM RESULT";
		int no = 1;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				no = rs.getInt(1)+1;
			}
			pstmt.close();
			
			sql = "INSERT INTO RESULT VALUES(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, score);
			pstmt.setString(2, ex_object2);
			pstmt.setInt(3, ex_code);
			pstmt.setString(4, mem_id);
			pstmt.setInt(5, no);
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
