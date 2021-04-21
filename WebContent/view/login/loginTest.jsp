<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=1,initial-scale=1,user-scalable=1" />
<title>로그인</title>
<link
	href="http://fonts.googleapis.com/css?family=Lato:100italic,100,300italic,300,400italic,400,700italic,700,900italic,900"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="assets/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="assets/css/styles.css" />
<style>
body {
	background: url(../login/assets/images/login_background.jpg) no-repeat
		center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
</style>
</head>
<body>
	<%
		session.invalidate();
	%>
	<section class="container login-form">
		<section>
			<form method="post" action="loginAction.jsp" role="login">
				<img src="assets/images/login_logo.png" alt=""
					class="img-responsive" />

				<div class="form-group">
					<input type="text" class="form-control" placeholder="ID"
						name="logid" maxlength="20">
				</div>

				<div class="form-group">
					<input type="password" class="form-control" placeholder="PASSWORD"
						name="pwd" maxlength="20">
				</div>

				<button type="submit" name="go" class="btn btn-primary btn-block">LOGIN</button>

				<a href="../join/joinTest.jsp">JOIN US</a>
			</form>
		</section>
	</section>

	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>


</body>
</html>
