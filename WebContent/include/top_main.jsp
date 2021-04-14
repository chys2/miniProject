<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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

</style>
</head>
<body>
	<%
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	} %>
<header class="header">
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#"></a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="main2.jsp">홈</a></li>
      <li><a href="#">강아지에 의한 지출</a></li>
      <li><a href="#">강아지를 위한 일기</a></li>
      <li><a href="bbs2.jsp">강아지의친구</a></li>
    </ul>
    <%
			if (logId == null) { //로그인 안 했을때
			%>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="login2.jsp"><span class="glyphicon glyphicon-user"></span> 로그인</a></li>
      <li><a href="join2.jsp"><span class="glyphicon glyphicon-log-in"></span> 회원가입</a></li>
    </ul>
    <%
			} else{ //로그인 했을때
			%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
					<li><a href="#">마이페이지</a>
					</li>
						<li><a href="loginOutAction2.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
			}
			%>
  </div>
</nav>
</header>


</body>
</html>