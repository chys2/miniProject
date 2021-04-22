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
       
	 public frontController() {
	        super();
	        // TODO Auto-generated constructor stub
	    }
	   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		      // TODO Auto-generated method stub
		      actionDo(request, response);
		   }

	
	   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		      // TODO Auto-generated method stub
		      doGet(request, response);
		   }
	public void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri=request.getRequestURI();
	      System.out.println("uri: "+ uri);
	      String ctxPath=request.getContextPath();
	      System.out.println("ctxPath: "+ctxPath);
	      String cmd=uri.substring(ctxPath.length());

		if(cmd.equals("/view/test.action")) {
			System.out.println("test");
			response.sendRedirect(request.getContextPath()+"/view/test.jsp");
		}

	}
	
	

}
