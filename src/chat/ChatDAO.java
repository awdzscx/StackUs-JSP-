package chat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.swing.RepaintManager;

public class ChatDAO {
	
	public Connection getConnection() throws Exception{ 
		Context ctx = new InitialContext(); 
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public ArrayList<Chat> getChatList(String nowTime) {
		Connection conn = null;
		ArrayList<Chat> chatList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "SELECT * FROM CHAT WHERE chatTime > ? ORDER BY chatTime";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nowTime);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<Chat>();
			
			while (rs.next()) {
				Chat chat = new Chat();
				chat.setChatID(rs.getInt("chatID"));
				chat.setChatName(rs.getString("chatName"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getNString("chatTime").substring(11,13));
				String timeType = "오전";
				if (Integer.parseInt(rs.getNString("chatTime").substring(11,13)) >= 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+" "+timeType+" "+chatTime+":" + rs.getString("chatTime").substring(14, 16)+"");
				chatList.add(chat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return chatList;
	}
	
	public ArrayList<Chat> getChatListByRecent(int number, String cla_name) {
		Connection conn = null;
		ArrayList<Chat> chatList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "SELECT * FROM CHAT WHERE chatID > (select max(chatID) - ? from chat) and cla_name = ? ORDER BY chatTime";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, cla_name);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<Chat>();
			
			while (rs.next()) {
				Chat chat = new Chat();
				chat.setChatID(rs.getInt("chatID"));
				chat.setChatName(rs.getString("chatName"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setChatImg(rs.getString("chatImg"));
				chat.setCla_name(rs.getString("cla_name"));
				int chatTime = Integer.parseInt(rs.getNString("chatTime").substring(11,13));
				String timeType = "오전";
				if (Integer.parseInt(rs.getNString("chatTime").substring(11,13)) >= 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+" "+timeType+" "+chatTime+":" + rs.getString("chatTime").substring(14, 16)+"");
				chatList.add(chat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return chatList;
	}
	
	public ArrayList<Chat> getChatListByRecent(String chatID,String cla_name) {
		Connection conn = null;
		ArrayList<Chat> chatList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "SELECT * FROM CHAT WHERE chatID > ? and cla_name = ? ORDER BY chatTime";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(chatID));
			pstmt.setString(2, cla_name);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<Chat>();
			
			while (rs.next()) {
				Chat chat = new Chat();
				chat.setChatID(rs.getInt("chatID"));
				chat.setChatName(rs.getString("chatName"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setChatImg(rs.getString("chatImg"));
				chat.setCla_name(rs.getString("cla_name"));
				int chatTime = Integer.parseInt(rs.getNString("chatTime").substring(11,13));
				String timeType = "오전";
				if (Integer.parseInt(rs.getNString("chatTime").substring(11,13)) >= 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+" "+timeType+" "+chatTime+":" + rs.getString("chatTime").substring(14, 16)+"");
				chatList.add(chat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return chatList;
	}
	
	
	public int submit(String chatName, String chatContent,String chatImg,String cla_name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int num = 0;
		
		try {
			conn = getConnection();
			
			sql="select max(chatID) from chat";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				num = rs.getInt(1)+1;
			}else {
				num = 1;
			}
			
			sql = "INSERT INTO CHAT VALUES(?,?,?, sysdate,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, chatName);
			pstmt.setString(3, chatContent);
			pstmt.setString(4, chatImg);
			pstmt.setString(5, cla_name);
			pstmt.executeUpdate();
			return 1; 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return -1;
	}
	
	
}
