<%@page import="java.net.URLEncoder"%>
<%@page import="Jdbc.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="dao.TitleImageDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="vo.MemberVo"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<title>top_menu_1</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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

.side {
	background: rgba(217, 217, 217, 0.1);
	width: 19%;
	height: 84%;
	border: 1px dashed #8c8c8c;
	border-radius: 20px;
	float: left;
	text-align: center;
	margin-left:1%;
	margin-bottom: 1%;

}

.inaside {
	width: 100%;
	height: 40%;
	float: left;
	
}

#profile {
	margin-top: 300px;
}

#menubtn {
	height: 50px;
	width: 200px;
	margin-top: 25px;
	margin-left: 70px;
}

#menuform {
	height: 100%;
	width: 900px;
	background: #FDCD8C;
}
</style>
</head>
<body>
	<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Connection conn = null;

	
	
	
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}else if(session.getAttribute("logId") == null){
		String msg ="로그인을 먼저 해주세요.";
		msg=URLEncoder.encode(msg,"UTF-8");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 먼저해주세요.')");
		script.println("location.href='../login/login.jsp'");
		script.println("</script>");
		
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
	}else{ alert("비밀번호가 올바르지 않습니다.");
	location.href = "../accountbook/accountbook.jsp"
	}
}

</script>
	
	
	<header class="header">
		<nav class="navbar navbar-inverse">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="#"></a>
				</div>
				<ul class="nav navbar-nav">
					<li><a href="../main/main.jsp">홈</a></li>
					<li class="active"><a href="../accountbook/accountbook.jsp">강아지에 의한 지출</a></li>
					<li><a href="../diary/diary.jsp">강아지를 위한 일기</a></li>
					<li><a href="../bbs/bbs.jsp">강아지의친구</a></li>
				</ul>
				<%
				if (logId == null) { //로그인 안 했을때
				%>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="../login/login.jsp"><span
							class="glyphicon glyphicon-user"></span> 로그인</a></li>
					<li><a href="../join/join.jsp"><span
							class="glyphicon glyphicon-log-in"></span> 회원가입</a></li>
				</ul>
				<%
				} else { //로그인 했을때
				%>
				<ul class="nav navbar-nav navbar-right">
					<li class="active"><a href="#"><b><%=logId %></b>님 접속중</a></li>
					
						<li><a href="#"  onclick=move_mypage()><span class="glyphicon glyphicon-user"></span>&nbsp;마이페이지</a>
					</li>
					<li><a href="../login/loginOutAction.jsp"><span
							class="glyphicon glyphicon-log-in"></span>&nbsp;로그아웃</a></li>
				</ul>

				
							

				<%
				}
				%>
			</div>
		</nav>
	</header>
	
		<%
			MemberDAO profile = new MemberDAO();
			ArrayList<MemberVo> list = profile.getproFile(logId);
			TitleImageDAO title = new TitleImageDAO(); 
			String titlename = title.view(logId);       %>
	<aside class="side">

		<aside class="inaside"><img src="../../profile/<%=titlename%>" width="100%" height="100%" style="border-radius: 20px;"/></aside>
		<div id="profile">
			<h2>프로필</h2>
			<br>
			<%
			

			for (int i = 0; i < list.size(); i++) {
			%>
			<%
			System.out.println("출력");
			%>
			<span class="glyphicon glyphicon-heart"></span>&nbsp;댕댕이름:
			<%=list.get(i).getDogname()%>
			<br> <br> <span class="glyphicon glyphicon-heart-empty"></span>
			&nbsp;나이:
			<%=list.get(i).getAge()%>
			<br> <br> <span class="glyphicon glyphicon-heart"></span>&nbsp;성별:
			<%=list.get(i).getGender()%>
			<br> <br> <span class="glyphicon glyphicon-envelope"></span>
			&nbsp;이메일:
			<%=list.get(i).getEmail()%>

			<%
			}
			
		
			ArrayList<vo.TitleimageVo> check = title.getList(logId);

			%>
			
			<form method="post" action="../../profile/testTitleAction.jsp"
					enctype="multipart/form-data">
						<br><input type="file" class="btn btn primary pull-right" name="titleimages">
          
          
			<% if(check.size() == 0){%>
           <br> <input type="submit"  style="margin-center: 0px"
						class="btn btn primary pull-right" value="이미지 등록">
						
            <% }else {%>
           <br> <input type="submit"  style="margin-center: 0px"
						class="btn btn primary pull-right" value="이미지 수정">
						
            <% }%>
            
            
           </form>
		</div>

	</aside>

<%
profile.close();
mem.close();
title.close();
%>
</body>
</html>
