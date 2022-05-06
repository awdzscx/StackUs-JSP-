package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean(); //instance�� ��ü ����
	public static BoardDBBean getInstance() { // instance �����ϴ� getInstance() �޼ҵ�
		return instance;
	}
	
	public Connection getConnection() throws Exception{ 
		Context ctx = new InitialContext(); 
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertBoard(BoardBean board) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int re=-1;
		int num;
		
		try {
			conn = getConnection();
			
			sql="select max(bo_no) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				num = rs.getInt(1)+1;
			}else {
				num = 1;
			}
			pstmt.close();
			conn.close();
			
			conn = getConnection();
			sql = "insert into board (bo_date, bo_content, bo_title, bo_no, bo_hit, member_mem_id,bo_type) values(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setTimestamp(1,board.getBo_date());
			pstmt.setString(2,board.getBo_content());
			pstmt.setString(3,board.getBo_title());
			pstmt.setInt(4,num);
			pstmt.setInt(5,0);
			pstmt.setString(6,board.getMem_id());
			pstmt.setInt(7,board.getBo_type());
			
			pstmt.executeUpdate();
			
			re=1;
 			pstmt.close();
 			conn.close();
 			
		} catch (Exception e) {
			System.out.println("�۾��� ����");
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
	
	public ArrayList<BoardBean> listBoard(String pageNumber,int bo_type, int sq){
		Connection con=null;
		Statement stmt=null;
		ResultSet rs=null;
		ResultSet pageSet=null;
		
		int dbCount=0;
		int absolutePage=1;
		
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try {
			con = getConnection();
			stmt = con.createStatement();
			String sql = "SELECT COUNT(BO_NO) FROM BOARD where bo_type ="+bo_type;
			pageSet = stmt.executeQuery(sql);
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
				stmt.close();
			}
			
			if (dbCount % BoardBean.pageSize == 0) {	//80
				BoardBean.pageCount = dbCount / BoardBean.pageSize;
			} else {	//84
				BoardBean.pageCount = dbCount / BoardBean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				BoardBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2: 1*10+1=11
				absolutePage = (BoardBean.pageNum - 1) * BoardBean.pageSize + 1;
			}
			
			//stmt = conn.createStatement();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			if (sq == 1) {
				sql = "select bo_type, bo_date, bo_content, bo_title, bo_no, bo_hit, member_mem_id, (SELECT COUNT(*) FROM BOARD_LIKE WHERE BOARD_BO_NO = b.bo_no) count from board b where bo_type = "+bo_type+" order by count desc";
			}  else {
				sql = "SELECT * FROM BOARD WHERE BO_TYPE ="+bo_type+" ORDER BY BO_NO DESC";
			}
			rs = stmt.executeQuery(sql);
 			
 			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
	 			while (count < BoardBean.pageSize) {
	 				BoardBean board = new BoardBean();
	 				
					board.setBo_date(rs.getTimestamp("bo_date"));
					board.setBo_content(rs.getString("bo_content"));
					board.setBo_title(rs.getString("bo_title"));
					board.setBo_no(rs.getInt("bo_no"));
					board.setBo_hit(rs.getInt("bo_hit"));
					board.setMem_id(rs.getString("member_mem_id"));
					
	 				boardList.add(board);
	 				
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
		
		return boardList;
	}
	
	
	public ArrayList<BoardBean> listBoardP(){
		Connection con=null;
		Statement stmt = null; 
		ResultSet rs = null;
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try {
			con = getConnection();
			stmt = con.createStatement();
			String sql = "select bo_type, bo_date, bo_content, bo_title, bo_no, bo_hit, member_mem_id, (SELECT COUNT(*) FROM BOARD_LIKE WHERE BOARD_BO_NO = b.bo_no) count from board b order by count desc";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				BoardBean  board = new BoardBean();
				
				board.setBo_date(rs.getTimestamp("bo_date"));
				board.setBo_content(rs.getString("bo_content"));
				board.setBo_title(rs.getString("bo_title"));
				board.setBo_no(rs.getInt("bo_no"));
				board.setBo_hit(rs.getInt("bo_hit"));
				board.setMem_id(rs.getString("member_mem_id"));
				
				boardList.add(board); 
				
				if (boardList.size() == 4) return boardList;
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
		return boardList;
	}
	
	public BoardBean getBoard(int bo_no ,boolean hitadd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		BoardBean board = null;
		
		try {
			conn = getConnection();
			
			if (hitadd == true) {
				sql="update board set bo_hit=bo_hit+1 where bo_no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bo_no);
				pstmt.executeUpdate();
			}
			
			sql = "select * from board where bo_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bo_no);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				board = new BoardBean();
				board.setBo_date(rs.getTimestamp("bo_date"));
				board.setBo_content(rs.getString("bo_content"));
				board.setBo_title(rs.getString("bo_title"));
				board.setBo_no(rs.getInt("bo_no"));
				board.setBo_hit(rs.getInt("bo_hit"));
				board.setMem_id(rs.getString("member_mem_id"));
				board.setBo_type(rs.getInt("bo_type"));
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
		return board;
	}
	
	public int deleteBoard(int bo_no) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String pwd="";
		int re=-1;
		
		try {
			conn = getConnection();
			sql = "delete from board_like where board_bo_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bo_no);
			pstmt.executeUpdate();
			
			sql ="delete from comments where board_bo_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bo_no);
			pstmt.executeUpdate();
			
			sql="delete from board where bo_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bo_no);
			pstmt.executeUpdate();
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
	
	public int editBoard(BoardBean board) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String pwd="";
		int re=-1;
		
		try {
			conn = getConnection();
			
			sql="update board set bo_title=?, bo_content=? where bo_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getBo_title());
			pstmt.setString(2, board.getBo_content());
			pstmt.setInt(3, board.getBo_no());
			pstmt.executeUpdate();
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
	public void likeBoard(int bo_no, String mem_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO BOARD_LIKE(BOARD_BO_NO, MEMBER_MEM_ID) VALUES(?,?)";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bo_no);
			pstmt.setString(2, mem_id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	public void disLikeBoard(int bo_no, String mem_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "delete FROM BOARD_LIKE WHERE BOARD_BO_NO = ? AND MEMBER_MEM_ID = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bo_no);
			pstmt.setString(2, mem_id);
			pstmt.executeUpdate();
			
			con.close();
			pstmt.close();
			
			con = getConnection();
			sql = "commit";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
					
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	} 
	
	public int board_Like_Sum(int bo_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM BOARD_LIKE WHERE BOARD_BO_NO = ?";
		int likeSum = 0;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bo_no);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				likeSum = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close(); 
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return likeSum;
	}
	public boolean already_Like(int bo_no, String mem_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM BOARD_LIKE WHERE BOARD_BO_NO = ? AND MEMBER_MEM_ID = ?";
		boolean already = false;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bo_no);
			pstmt.setString(2, mem_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				already = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close(); 
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return already;
	}
	
	public ArrayList<BoardBean> listBoard_search(String pageNumber, int sq,String search){
		Connection con=null;
		Statement stmt=null;
		ResultSet rs=null;
		ResultSet pageSet=null;
		
		int dbCount=0;
		int absolutePage=1;
		
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try {
			con = getConnection();
			stmt = con.createStatement();
			String sql = "SELECT COUNT(BO_NO) FROM BOARD ";
			pageSet = stmt.executeQuery(sql);
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
				stmt.close();
			}
			
			if (dbCount % BoardBean.pageSize == 0) {	//80
				BoardBean.pageCount = dbCount / BoardBean.pageSize;
			} else {	//84
				BoardBean.pageCount = dbCount / BoardBean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				BoardBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2: 1*10+1=11
				absolutePage = (BoardBean.pageNum - 1) * BoardBean.pageSize + 1;
			}
			//stmt = conn.createStatement();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			if (sq == 1) {
				sql = "select bo_type, bo_date, bo_content, bo_title, bo_no, bo_hit, member_mem_id, (SELECT COUNT(*) FROM BOARD_LIKE WHERE BOARD_BO_NO = b.bo_no) count from board b where bo_title like"+"'%"+search+"%'"+" order by count desc";
			}  else {
				sql = "select * from board where bo_title like"+"'%"+search+"%'"+" order by bo_no desc";
			}
			rs = stmt.executeQuery(sql);
 			
 			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
	 			while (count < BoardBean.pageSize) {
	 				BoardBean board = new BoardBean();
	 				
					board.setBo_date(rs.getTimestamp("bo_date"));
					board.setBo_content(rs.getString("bo_content"));
					board.setBo_title(rs.getString("bo_title"));
					board.setBo_no(rs.getInt("bo_no"));
					board.setBo_hit(rs.getInt("bo_hit"));
					board.setMem_id(rs.getString("member_mem_id"));
					board.setBo_type(rs.getInt("bo_type"));
					
	 				boardList.add(board);
	 				
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
		
		return boardList;
	}
}
