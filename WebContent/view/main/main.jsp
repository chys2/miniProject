<%@page import="dao.BbsDAO"%>
<%@page import="dao.AccountBookDAO"%>
<%@page import="dao.DiaryDAO"%>
<%@page import="Jdbc.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
<meta name="viewprot" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style>
html, body {
	margin: 0;
	padding: 0;
	height: 100%;
}
.header {
	width: 100%;
	height: 15%;
	color: white;
	
}
.section{
	background-color: #e1e3ef; 
	width:48%;
	height:83%;
 
	float:left;
	margin-left:1%;
	border: 3px solid #8c8c8c;
	
	
}
.section_right_top{
	width:49%;
	height:41%;
	
	float:left;
	margin-left:1%;
	margin-right:1%;
	border: 5px double #8c8c8c;
	background-color:#d9dee6;
}
.section_right_bottom{
	width:49%;
	height:40%;
 
	float:left;
	margin-left:1%;
	margin-right:1%;
	margin-top: 1%;
	border: 5px outset #e1e3ef;
	background-color:#9d9ea3;
}
</style>
</head>
<body>
<%
PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = null;
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
<header class="header">
<jsp:include page="/include/top_main.jsp" flush="false"/>
</header>
<section class="section">
<!-- 메뉴 1번 미리보기 -->
 <jsp:include page="../accountbook/accountbookPre.jsp" flush="false"/>
</section>
<section class="section_right_top">
<!-- 메뉴 2번 미리보기 -->
 <jsp:include page="../diary/diaryPre.jsp" flush="false"/> 
</section>
<section class="section_right_bottom">
<!-- 메뉴 3번 미리보기 -->
 <jsp:include page="../bbs/bbsPre.jsp" flush="false"/> 
</section>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
		<%
		DiaryDAO diaryDAO = new DiaryDAO();
		AccountBookDAO book = new AccountBookDAO();
		BbsDAO bbsDAO = new BbsDAO();
		
		System.out.println("ㅡㅡㅡㅡㅡ");
		
		diaryDAO.close();
		book.close();
		bbsDAO.close();
		
		%>
</body>
</html>