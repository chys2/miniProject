<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
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

<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	
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
		MemberDAO memberDAO = new MemberDAO();
	int result = memberDAO.login(member.getLogid(), member.getPwd());
	if (result == 1) {
		session.setAttribute("logId",member.getLogid());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 완료')");
		script.println("location.href = '../main/main.jsp'");
		script.println("</script>");
	}

	else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	}

	else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디를 확인해주세요.)");
		script.println("history.back()");
		script.println("</script>");
	}

	else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>


</body>
</html>