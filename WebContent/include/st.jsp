<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="vo.MemberVo"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<style>
html, body {
	margin: 0;
	padding: 0;
	height: 100%;
}

.header {
	width: 100%;
	height: 15%;
	background: skyblue;
	color: white;
	display: flex;
   justify-content: center;
   align-items: center;
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


#menubtn{
	height:50px;
	width:130px;

}

#menuform{
	height:100px;
	width:900px;
background: olivedrab;

}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>

	<header class="header"> 헤드 
	<form id ="menuform">
	<input type="button" id="menubtn" value="강아지에 의한 지출">
	<input type="button" id="menubtn" value="강아지를 위한 일기">
	<input type="button" id="menubtn" value="강아지의 친구">
	</form>
	</header>

	<aside class="side">

		<inaside class="inaside"> 사진 영역 </inaside>
		<div id="profile">
			<h1>프로필</h1>
			<br>
			<%
					
			
					MemberDAO profile = new MemberDAO();
					ArrayList<MemberVo> list = profile.getproFile("pink");

					for (int i = 0; i < list.size(); i++) {
					%>
			<%System.out.println("출력"); %>
			댕댕님 존함:
			<%=list.get(i).getDogname()%>
			<br> <br> 댕댕님 나이:
			<%=list.get(i).getAge()%>
			<br>
			<br> 댕댕님 성별:
			<%=list.get(i).getGender()%>
			<br>
			<br> 집사 이메일:
			<%=list.get(i).getEmail()%>


			<%
					}
					%>

		</div>

	</aside>
</body>
</html>