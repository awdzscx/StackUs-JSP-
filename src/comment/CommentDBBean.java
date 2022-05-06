package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CommentDBBean {
	private static CommentDBBean instance = new CommentDBBean(); //instanceï¿½ï¿½ ï¿½ï¿½Ã¼ ï¿½ï¿½ï¿½ï¿½
	public static CommentDBBean getInstance() { // instance ï¿½ï¿½ï¿½ï¿½ï¿½Ï´ï¿½ getInstance() ï¿½Þ¼Òµï¿½
		return instance;
	}
	
	public Connection getConnection() throws Exception{ 
		Context ctx = new InitialContext(); 
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertComment(CommentBean comment) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		CommentDBBean cm = CommentDBBean.getInstance();
		
		int re=-1;
		int num;
		int co_nom = comment.getCo_nom();
		int ref = comment.getCo_ref();
		int step = comment.getCo_step();
		int level = comment.getCo_level();
		int co_r_nom = cm.NomCount(comment.getBo_no());
		
		try {
			conn = getConnection();
			
			sql="select max(co_nom) from comments";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				num = rs.getInt(1)+1;
			}else {
				num = 1;
			}
			
			if (co_nom != 0) {
				sql="update comments set co_step = co_step +1 where co_ref=? and co_step > ?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				pstmt.executeUpdate();
				
				step =step+1;
				level=level+1;
			} else {
				ref = num;
				step = 0;
			}
			sql = "insert into comments (co_nom, co_content, co_date, board_bo_no, member_mem_id, co_ref, co_step,co_level,co_r_nom) values(?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1,num);
			pstmt.setString(2,comment.getCo_content());
			pstmt.setTimestamp(3,comment.getCo_date());
			pstmt.setInt(4,comment.getBo_no());
			pstmt.setString(5, comment.getMem_id());
			pstmt.setInt(6,ref);
			pstmt.setInt(7,step);
			pstmt.setInt(8,level);
			pstmt.setInt(9,co_r_nom);
			
			pstmt.executeUpdate();
			
			re=1;
 			pstmt.close();
 			conn.close();
 			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();				
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	
	public ArrayList<CommentBean> listComment(int bo_no){
		Connection con=null;
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		//dbï¿½ï¿½ï¿½ï¿½ ï¿½Þ±ï¿½ï¿½ï¿½ï¿½ï¿½
		ArrayList<CommentBean> commentList = new ArrayList<CommentBean>();
		
		try {
			con = getConnection();
			String sql = "select * from comments where board_bo_no = ? order by co_ref desc, co_step asc";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, bo_no);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				CommentBean  comment = new CommentBean();
				
				comment.setCo_nom(rs.getInt("co_nom"));
				comment.setCo_content(rs.getString("co_content"));
				comment.setCo_date(rs.getTimestamp("co_date"));
				comment.setBo_no(rs.getInt("board_bo_no"));
				comment.setMem_id(rs.getString("member_mem_id"));
				comment.setCo_ref(rs.getInt("co_ref"));
				comment.setCo_level(rs.getInt("co_level"));
				comment.setCo_step(rs.getInt("co_step"));
				comment.setCo_r_nom(rs.getInt("co_r_nom"));
				
				commentList.add(comment); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();	
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return commentList;
	}
	
	public CommentBean getComment(int co_nom) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		CommentBean comment = null;
		
		try {
			conn = getConnection();
			sql = "select * from comments where co_nom=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, co_nom);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				comment = new CommentBean();
				comment.setCo_date(rs.getTimestamp("co_date"));
				comment.setCo_content(rs.getString("co_content"));
				comment.setCo_nom(rs.getInt("co_nom"));
				comment.setBo_no(rs.getInt("board_bo_no"));
				comment.setMem_id(rs.getString("member_mem_id"));
				comment.setCo_ref(rs.getInt("co_ref"));
				comment.setCo_level(rs.getInt("co_level"));
				comment.setCo_step(rs.getInt("co_step"));
				comment.setCo_r_nom(rs.getInt("co_r_nom"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return comment;
	}
	
	public int deleteComment(int co_nom) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String pwd="";
		int re=-1;
		int count = 0;
		try {
			conn = getConnection();
			
			sql="select count(*) count from comments where co_ref = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, co_nom);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
			if (count > 1) {
				sql="update comments set co_content=? , member_mem_id = ? where co_nom=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "»èÁ¦µÈ ´ñ±ÛÀÔ´Ï´Ù.");
				pstmt.setString(2, "admin");//
				pstmt.setInt(3, co_nom);
				pstmt.executeUpdate();
			} else {
				sql="DELETE FROM COMMENTS WHERE CO_NOM = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, co_nom);
				pstmt.executeUpdate();
			}
			re=1;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	public int editBoard(CommentBean comment, String mem_pw) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String pwd="";
		int re=-1;
		
		try {
			conn = getConnection();
			sql="select mem_pw from member where mem_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comment.getMem_id());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pwd = rs.getString(1);
				if (pwd.equals(mem_pw)) {
					sql="update comments set co_content=? where co_nom=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, comment.getCo_content());
					pstmt.setInt(2, comment.getCo_nom());
					pstmt.executeUpdate();
					re=1;
				}else {
					re=0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	public int AllComment(int bo_no) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int re = 0;
		
		try {
			conn = getConnection();
			sql="select count(*) from comments where board_bo_no =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bo_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				re = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	public int NomCount(int bo_no ) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int re = 0;
		
		try {
			conn = getConnection();
			sql="select count(co_nom) from comments where co_step = 0 and board_bo_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bo_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				re = rs.getInt(1)+1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
}
