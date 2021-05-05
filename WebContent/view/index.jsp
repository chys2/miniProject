<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INDEX PAGE</title>
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