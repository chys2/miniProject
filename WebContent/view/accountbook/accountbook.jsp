<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.BbsDAO"%>
<%@ page import="vo.BbsVo"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
<meta name="viewprot" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

#accountForm {
	padding-top: 5%;
	height: 85%;
	width: 80%;
	float: right;
	/* background: yellow; */
}

#container {
	background: yellow;
	height: 80%;
}

#container_2 {
	background: pink;
	height: 100%;
	width: 65%;
	float: left;
}

#container_3 {
	background: skyblue;
	height: 100%;
	width: 40%;
	float: right;
}
</style>
</head>
<body>
	<%
	session.getAttribute("logId");
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	%>
	<jsp:include page="/include/top_menu_1.jsp" flush="false" />
	<form id="accountForm">
		<div class="container" id="container">
			<div class="row" id="container_2">그래프 영역</div>
			
			
			<div class="row" id="container_3">입출력 영역</div>
		</div>
	</form>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>