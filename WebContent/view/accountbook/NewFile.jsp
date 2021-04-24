<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.AccountBookDAO"%>
<%@ page import="vo.AccountBookVo"%>
<%@ page import="vo.MemberVo"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
ㅇㄴㅁㅇㅁ
	<%
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	
	
	
	AccountBookDAO book = new AccountBookDAO();
	ArrayList<AccountBookVo> list2= book.getAccount("test");
	%>
			 <%	for (int i = 0; i < list2.size(); i++) {
    			%>
        	<%
			System.out.println("출력2");
			%>
          <%=list2.get(i).getMeal() %>
           <%=list2.get(i).getClothes() %>   
         <%=list2.get(i).getHospital() %>
          <%=list2.get(i).getHair() %>
           <%=list2.get(i).getEtc() %>
        	<%}%>
        	<%
			System.out.println("출력3");
			%>
        	<%
			MemberDAO profile = new MemberDAO();
			ArrayList<MemberVo> list = profile.getproFile("test");
			    %>

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
			%>
</body>
</html>