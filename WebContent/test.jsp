<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�����ͺ��̽� ���� : dbconnect.jsp</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<h2>�����ͺ��̽� ����̹��� DB univdb ���� ���� ���α׷�</h2>
	<%
		try {
		String driverName = "oracle.jdbc.OracleDriver";
		String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "c##root", "root");
		out.println("MySql �����ͺ��̽� univdb�� ���������� �����߽��ϴ�");
		con.close();
	} catch (Exception e) {
		out.println("MySql �����ͺ��̽� univdb ���ӿ� ������ �ֽ��ϴ�. <hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	}
	%>
</body>
</html>