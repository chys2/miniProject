<%@page import="Jdbc.JdbcUtil"%>
<%@page import="vo.AccountBookVo"%>
<%@page import="dao.AccountBookDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.DiaryDAO"%>
<%@ page import="vo.DiaryVo"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">

<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Connection conn = null;
	
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	AccountBookVo accountbook = new AccountBookVo();
	AccountBookDAO accountbookDAO = new AccountBookDAO();
	
	

	String account =request.getParameter("account");
	String date =request.getParameter("date");
	String beforedate =request.getParameter("beforedate");
	String afterdate =request.getParameter("afterdate");
	System.out.println(account);
	//지출 항목
	
	String money=request.getParameter("money");
	boolean isNumeric =  money.matches("[+-]?\\d*(\\.\\d+)?");
	/* 문자를 숫자로 확인  */
	if (logId == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href ='../login/login.jsp'");
		script.println("</script>");
	}else{
		if  (money.equals("") ||money==null ||date.equals("") ||date ==null ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(isNumeric!=true){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('숫자만 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			int result = accountbookDAO.accountinsert(accountbook.getAccountbookID(), logId, account, money, date,accountbook.getAccountbookAvailable() );
			
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}

			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('지출내역을 작성하였습니다.')");
				script.println("location.href='accountbook.jsp'");
				script.println("</script>");
			}
		}
		
		
	}

	accountbookDAO.close();
	%>


</body>
</html>