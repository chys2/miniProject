
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO_test"%>
<%@ page import="vo.MemberVo"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	MemberDAO_test dao = MemberDAO_test.getInstance();
	
	ArrayList<vo.MemberVo> list = dao.selectMemberAll();
	%>


	<table border="1">
		<tr>
			<th>logId</th>
			<th>Pwd</th>
			<th>DogName</th>
			<th>Email</th>
			<th>Gender</th>
			<th>AGE</th>
		</tr>
		<%
		for (int i = 0; i < list.size(); i++) {
		%>

		<tr>
			<td><%=list.get(i).getLogid()%></td>
			<td><%=list.get(i).getPwd()%></td>
			<td><%=list.get(i).getDogname()%></td>
			<td><%=list.get(i).getEmail()%></td>
			<td><%=list.get(i).getGender()%></td>
			<td><%=list.get(i).getAge()%></td>
		</tr>
		<%
		}
		%>

	</table>
	
	
</body>
</html>