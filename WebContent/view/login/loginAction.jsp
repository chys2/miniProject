<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="Jdbc.*" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="member" class="vo.MemberVo" scope="page" />
<jsp:setProperty name="member" property="logid" />
<jsp:setProperty name="member" property="pwd" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">

<title>로그인</title>
</head>
<body>
	<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Connection conn = null;
	String logId =null;
	if(session.getAttribute("logId") != null){
		logId =(String) session.getAttribute("logId");
	}
	if(logId != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href ='../main/main.jsp'");
		script.println("history.back()");
		script.println("</script>");
	}
		
	
	if (member.getLogid()==null || member.getPwd()==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		}else {
		MemberDAO memberDAO = new MemberDAO();
		
		PrintWriter script = response.getWriter();
		int result = memberDAO.login(member.getLogid(), member.getPwd());
	
		
		if (result == 1) {
		
			
			session.setAttribute("logId",member.getLogid());
			script.println("<script>");
			script.println("alert('로그인 완료')");
			script.println("location.href = '../main/main.jsp'");
			script.println("</script>");
			memberDAO.close();
		} else if (result == 0) {
			
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else if (result == -1) {
			script.println("<script>");
			script.println("alert('아이디를 확인해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}else if (result == -2) {
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} 
		
		memberDAO.close();
		
		}

	%>


</body>
</html>