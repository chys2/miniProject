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
}
.side {
	width: 20%;
	height: 85%;
	background: pink;
	color: white;
	float:left;	
}

.inaside {
   width: 100%;
   height: 40%;
   float: left;
   background: olivedrab;
}


</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header class="header">
		헤드
	</header>
	
	  <aside class="side">

      <inaside class="inaside"> 
       사진 영역
       </inaside>
       
        <h1>댕댕님 프로필</h1>
			<%
					
			
					MemberDAO profile = new MemberDAO();
					ArrayList<MemberVo> list = profile.getproFile("test");

					for (int i = 0; i < list.size(); i++) {
					%>
					<%System.out.println("출력"); %>
					<%=list.get(i).getDogname()%>
					
					<%=list.get(i).getAge()%>
					<%=list.get(i).getGender()%>
					<%=list.get(i).getEmail()%>
					

					<%
					}
					%>
      
         <!--  사이드바 -->

         <div id="profile">

           이름: PINK<br>
           나이: 핑크입니다<br>
        	성별: 여자<br>
        	이메일: 이메일<br>
         
            </div>

   </aside>
</body>
</html>