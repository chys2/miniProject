<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">

<title>로그아웃</title>
</head>
<body>
<%MemberDAO member = new MemberDAO();
member.close();%>

	<script>
		location.href = "../index.jsp"
	</script>
</body>
</html>