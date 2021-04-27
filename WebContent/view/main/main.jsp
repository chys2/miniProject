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
	width:48%;
	height:83%;
	background-color: powderblue;
	float:left;
	margin-left:1%;
	border: 1px;
	
	
}
.section_right_top{
	width:49%;
	height:41%;
	background-color: pink;
	float:left;
	margin-left:1%;
	margin-right:1%;
}
.section_right_bottom{
	width:49%;
	height:40%;
	background-color: blue;
	float:left;
	margin-left:1%;
	margin-right:1%;
	margin-top: 1%;
}
</style>
</head>
<body>
<%String logid = request.getParameter("logid");
session.setAttribute("userId", logid);%>
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
</body>
</html>