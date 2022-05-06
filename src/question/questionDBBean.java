package question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class questionDBBean {
	private static questionDBBean instance = new questionDBBean();
	
	public static questionDBBean getInstance() {
		return instance;
	}
	
	public static Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertQuestion(questionBean question){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int q_no= 0;
		int re = -1;
		
		try {
			con = getConnection();
			sql = "SELECT MAX(Q_NO) FROM QUESTION WHERE CLA_NAME = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, question.getCla_name());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				q_no = rs.getInt(1)+1;
			}
			rs.close();
			pstmt.close();
			
			sql = "INSERT INTO QUESTION(Q_NO, Q_CORRECT, Q_INCORRECT, Q_FNAME, Q_ANSWER, Q_RIGHT, CLA_NAME, SUBJECT_SUBJECT_NAME,Q_TITLE, Q_EXPLAIN, a1, a2, a3, a4) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, q_no);
			pstmt.setInt(2, 0);
			pstmt.setInt(3, 0);
			pstmt.setString(4, question.getQ_fname());
			pstmt.setString(5, question.getQ_answer());
			pstmt.setInt(6, question.getQ_right());
			pstmt.setString(7, question.getCla_name());
			pstmt.setString(8, question.getSubject_subject_name());
			pstmt.setString(9, question.getQ_title());
			pstmt.setString(10, question.getQ_explain());
			pstmt.setString(11, question.getA1());
			pstmt.setString(12, question.getA2());
			pstmt.setString(13, question.getA3());
			pstmt.setString(14, question.getA4());
			re = pstmt.executeUpdate();
			
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
	
	public ArrayList<questionBean> questionList(String cla_name){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT Q_NO, ROUND(Q_CORRECT/decode((Q_CORRECT+Q_INCORRECT),0,-1,(Q_CORRECT+Q_INCORRECT))*100,2), CLA_NAME FROM QUESTION WHERE CLA_NAME = ? ORDER BY 2";
		ArrayList<questionBean> list = new ArrayList<questionBean>();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				questionBean bean = new questionBean();
				
				bean.setQ_no(rs.getInt(1));
				if(rs.getDouble(2)==0) {
					bean.setPercent(-1);
				}else {
					bean.setPercent(rs.getDouble(2));
				}
				bean.setCla_name(rs.getString(3));
				
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
	public int getQ_no(String cla_name){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT count(q_no) FROM QUESTION WHERE CLA_NAME = ?";
		int count = 0;
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
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
	public ArrayList<String> getFname(String cla_name){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT Q_FNAME FROM QUESTION WHERE CLA_NAME = ? ORDER BY Q_NO";
		ArrayList<String> list = new ArrayList<String>();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				list.add(rs.getString(1));
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
	public int getPercent(String cla_name ,int q_no){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT (Q_CORRECT/(Q_INCORRECT+Q_CORRECT))*100 FROM QUESTION WHERE Q_NO = ? AND CLA_NAME =?";
		int percent = 0;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, q_no);
			pstmt.setString(2, cla_name);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				percent = rs.getInt(1);
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
		return percent;
	}
	public int getRight(String cla_name, int q_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT Q_RIGHT FROM QUESTION WHERE CLA_NAME = ? AND Q_NO =?";
		int right = 0;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			pstmt.setInt(2, q_no);
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
	public void upCorrect(String cla_name, int q_no){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE QUESTION SET Q_CORRECT = Q_CORRECT+1 WHERE Q_NO = ? AND CLA_NAME =?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, q_no);
			pstmt.setString(2, cla_name);
			pstmt.executeUpdate();
			
			
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
	}
	public void upIncorrect(String cla_name, int q_no){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE QUESTION SET Q_INCORRECT = Q_INCORRECT+1 WHERE Q_NO = ? AND CLA_NAME =?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, q_no);
			pstmt.setString(2, cla_name);
			pstmt.executeUpdate();
			
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
	}
	public String getAnswer(String cla_name, int q_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="SELECT Q_ANSWER FROM QUESTION WHERE CLA_NAME = ? AND Q_NO = ?";
		String answer = "";
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			pstmt.setInt(2, q_no);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				answer = rs.getString(1);
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
		return answer;
	}
	public questionBean getQ(String cla_name, int q_no){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT Q_TITLE, Q_EXPLAIN, A1, A2, A3, A4 FROM QUESTION WHERE CLA_NAME = ? AND Q_NO = ?";
		questionBean bean = new questionBean();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cla_name);
			pstmt.setInt(2, q_no);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				bean.setQ_title(rs.getString(1));
				bean.setQ_explain(rs.getString(2));
				bean.setA1(rs.getString(3));
				bean.setA2(rs.getString(4));
				bean.setA3(rs.getString(5));
				bean.setA4(rs.getString(6));
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
		return bean;
	}
	public int getSum(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM QUESTION";
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
}
