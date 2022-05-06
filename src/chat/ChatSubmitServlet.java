package chat;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChatSubmitServlet
 */
@WebServlet("/ChatSubmitServlet")
public class ChatSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String chatName = URLDecoder.decode(request.getParameter("chatName"), "utf-8");
		String chatContent = URLDecoder.decode(request.getParameter("chatContent"), "utf-8");
		String chatImg = URLDecoder.decode(request.getParameter("chatImg"), "utf-8");
		String cla_name = URLDecoder.decode(request.getParameter("cla_name"), "utf-8");
		if (chatName == null || chatName.equals("") || chatContent == null || chatContent.equals("")|| chatImg == null || chatImg.equals("") || cla_name == null || cla_name.equals("") ) {
			response.getWriter().write("0");
		} else {
			response.getWriter().write(new ChatDAO().submit(chatName, chatContent, chatImg, cla_name)+"");
		}
	}

}
