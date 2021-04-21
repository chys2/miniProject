<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
    <%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="vo.MemberVo"%>
<%@ page import="java.util.ArrayList"%>
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
.side {
	width: 20%;
	height: 85%;
	background: pink;
	color: white;
	float: left;
	text-align: center;
}

.inaside {
	width: 100%;
	height: 40%;
	float: left;
	background: olivedrab;
}

#profile {
	margin-top: 300px;
}

#menubtn {
	height: 50px;
	width: 200px;
	margin-top:25px;
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
      <li ><a href="../main/main.jsp">홈</a></li>
      <li class="active"><a href="#">강아지에 의한 지출</a></li>
      <li><a href="../diary/diary.jsp">강아지를 위한 일기</a></li>
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
			} else { //로그인 했을때
			%>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="../mypage/mypage.jsp"><span class="glyphicon glyphicon-user"></span>&nbsp마이페이지</a>
					</li>
						<li><a href="../login/loginOutAction.jsp"><span class="glyphicon glyphicon-log-in"></span>&nbsp로그아웃</a></li>
					</ul>
 -->			</ul>
			<%
			}
			%>
  </div>
</nav>
</header>
<aside class="side">

		<inaside class="inaside"> 사진 영역 </inaside>
		<div id="profile">
			<h1>프로필</h1>
			<br>
			<%
			MemberDAO profile = new MemberDAO();
			ArrayList<MemberVo> list = profile.getproFile(logId);

			for (int i = 0; i < list.size(); i++) {
			%>
			댕댕님 존함:
			<%=list.get(i).getDogname()%>
			<br> <br> 댕댕님 나이:
			<%=list.get(i).getAge()%>
			<br> <br> 댕댕님 성별:
			<%=list.get(i).getGender()%>
			<br> <br> 집사 이메일:
			<%=list.get(i).getEmail()%>


			<%
			}
			%>

		</div>

	</aside>

</body>
</html>
