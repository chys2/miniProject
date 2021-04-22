package testservlet;

import java.io.IOException;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class JoinProc
 */
@WebServlet("/view/join/joinProc.do")
public class JoinProc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinProc() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost"); try {
			actionDo(request,response);
		} catch (ServletException | IOException | SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException,NamingException {
		System.out.println("actionDo");
		request.setCharacterEncoding("UTF-8");
		
		//?”μ²­ ?¨λ¬λ―Έν„° μ¶”μ¶
		String logid = request.getParameter("logid");
		String pwd = request.getParameter("pwd");
		String dogname = request.getParameter("dogname");
		String email = request.getParameter("email");
		String age = request.getParameter("age");
		String gender = request.getParameter("gender");
		
		//?”λΉ„ ?°κ²°
		InitialContext ic = new InitialContext();

		DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
		Connection conn = ds.getConnection();

		String sql="insert into Member  values(?,?,?,?,?,?)";
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,logid);
		pstmt.setString(2,pwd);
		pstmt.setString(3,dogname);
		pstmt.setString(4,email);
		pstmt.setString(5,gender);
		pstmt.setString(6,age);
		int result = pstmt.executeUpdate();
		
		pstmt.close(); conn.close();
		
		//?°μ΄???½μ… ???±κ³µ?΄λ©΄ joinResult.jsp,?¤ν¨λ©?joinFrm.jsp
		if(result!=0) {
			response.sendRedirect(request.getContextPath()+"/login/login.jsp");
		}else {
			response.sendRedirect(request.getContextPath()+"/join/join.jsp");
		}
		
	}

}