package chat;

public class Chat {
	private String chatName;
	private String chatContent;
	private String chatTime;
	private int chatID;
	private String chatImg;
	private String cla_name;
	
	public String getCla_name() {
		return cla_name;
	}
	public void setCla_name(String cla_name) {
		this.cla_name = cla_name;
	}
	public String getChatImg() {
		return chatImg;
	}
	public void setChatImg(String chatImg) {
		this.chatImg = chatImg;
	}
	public int getChatID() {
		return chatID;
	}
	public void setChatID(int chatID) {
		this.chatID = chatID;
	}
	public String getChatName() {
		return chatName;
	}
	public void setChatName(String chatName) {
		this.chatName = chatName;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatTime() {
		return chatTime;
	}
	public void setChatTime(String chatTime) {
		this.chatTime = chatTime;
	}
	
}
