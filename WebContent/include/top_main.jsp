<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Jdbc.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="dao.MemberDAO"%>
     <%@ page import="vo.MemberVo"%>
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
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Connection conn = null;
	String logId = null;
	if (session.getAttribute("logId") != null) {
	logId = (String) session.getAttribute("logId");
	}
	MemberDAO mem = new MemberDAO();
	ArrayList<MemberVo> m = mem.mypage(logId);
	String pwd = m.get(0).getPwd();
	%>

<script>
function move_mypage() {
	var pwdCheck = prompt("비밀번호를 입력해주세요");
	if(pwdCheck == <%=pwd%>){
		alert("확인되었습니다.");
		location.href = "../mypage/mypage.jsp"
	}else{ 
		alert("비밀번호가 올바르지 않습니다.");
	location.href ="../main/main.jsp"
	}
	
}

</script>
</head>
<body>
	
<header class="header">
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#"></a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="../main/main.jsp">홈</a></li>
      <li><a href="../accountbook/accountbook.jsp">강아지에 의한 지출</a></li>
      <li><a href="../diary/diary.jsp">강아지를 위한 일기</a></li>
      <li><a href="../bbs/bbs.jsp">강아지의친구</a></li>
    </ul>
    <%
			if (logId == null) { //로그인 안 했을때
			%>
     <ul class="nav navbar-nav navbar-right">
     
      <li><a href="../login/login.jsp"><span class="glyphicon glyphicon-user"></span> 로그인</a></li>
      <li><a href="../join/join.jsp"><span class="glyphicon glyphicon-log-in"></span> 회원가입</a></li>
    </ul> 
    <%
			} else{ //로그인 했을때
			%>
				<ul class="nav navbar-nav navbar-right">
				<li class="active"><a href="#"><b><%=logId %></b>님 접속중</a></li>
					<li><a href="#"  onclick=move_mypage()><span class="glyphicon glyphicon-user"></span>&nbsp;마이페이지</a>
					</li>
						<li><a href="../login/loginOutAction.jsp"><span class="glyphicon glyphicon-log-in"></span>&nbsp;로그아웃</a></li>
					</ul>
			
			<%
			}
			%>
				
  </div>
</nav>
</header>
<%mem.close(); %>

</body>
</html>
