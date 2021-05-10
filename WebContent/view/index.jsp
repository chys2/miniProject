<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<%
session.invalidate();
%>
<body>
	<script>
		location.href = './login/login.jsp';
	</script>
</body>
</html>