<%@page import="java.net.URLEncoder"%>
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
<jsp:setProperty name="member" property="pwdcheck" />
<jsp:setProperty name="member" property="dogname" />
<jsp:setProperty name="member" property="email" />
<jsp:setProperty name="member" property="gender" />
<jsp:setProperty name="member" property="age" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">

<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}else if(session.getAttribute("logId") == null){
		String msg ="로그인을 먼저 해주세요.";
		msg=URLEncoder.encode(msg,"UTF-8");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 먼저해주세요.')");
		script.println("location.href='../login/login.jsp'");
		script.println("</script>");
		
	}
	%>

	if (member.getLogid() == null || member.getPwd() == null || member.getPwdcheck() == null || member.getDogname() == null
			|| member.getEmail() == null || member.getGender() == null || member.getAge() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");

	} else if (!member.getPwd().equals(member.getPwdcheck())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호와 비밀번호 확인란이 일치하지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");

	}

	else if (member.getAge().matches("[+-]?\\d*(\\.\\d+)?") != true) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('나이에 숫자만 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");

	} else {

		MemberDAO memberDAO = new MemberDAO();
		int result = memberDAO.modify(member);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}

		else {
			session.setAttribute("logId", member.getLogid());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('정보수정이 되었습니다.')");
			script.println("location.href='../main/main.jsp'");
			script.println("</script>");
		}

	}
	%>


</body>
</html>