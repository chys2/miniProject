package testservlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class frontController
 */
@WebServlet("*.action")
public class frontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	
	}
	public void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
		String uri=request.getRequestURI(); System.out.println("uri:"+uri);
		String ctxPath=request.getContextPath(); System.out.println("ctxPath:" +ctxPath);
		String cmd =uri.substring(ctxPath.length()); System.out.println("cmd:"+cmd);
		if(cmd.equals("/view/test.action")) {
			System.out.println("test");
		}

	}
	
	

}
