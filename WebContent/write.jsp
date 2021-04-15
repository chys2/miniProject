<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
<meta name="viewprot" content="width=device-width" , initial-scale="1">
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>

			</button>
			<a class="navbar-brand" href="main.jsp">강강강</a>

		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
			if (logId == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li class="active"><a href="join.jsp">회원가입</a></li>

					</ul></li>
			</ul>
			<%
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="Action/loginOutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
			}
			%>

		</div>

	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="writeAction.jsp" enctype="multipart/form-data">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"	style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
							</tr>
							
							<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:350px;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
                   <input type="file" class="form-control"  name="bbsimages" size="40">
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>

	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>