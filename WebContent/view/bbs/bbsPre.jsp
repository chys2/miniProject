<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.BbsDAO"%>
<%@ page import="vo.BbsVo"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
<meta name="viewprot" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

#bbsForm {
	margin-top:3%;
	padding-top: 5%;
	margin-left:10%;
	height: 85%;
	width: 80%;
	float: left;

}
</style>
</head>
<body>
	<%
	session.getAttribute("logId");
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	<jsp:include page="/include/top_blank.jsp" flush="false" />
	<form id="bbsForm">
		<div class="container" style="width: 70%">
			<div class="row">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center">번호</th>
							<th style="background-color: #eeeeee; text-align: center">제목</th>
							<th style="background-color: #eeeeee; text-align: center">작성자</th>
							<th style="background-color: #eeeeee; text-align: center">작성일</th>
						</tr>
					</thead>
					<tbody>
						<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<BbsVo> list = bbsDAO.previewgetList(pageNumber);

						for (int i = 0; i < list.size(); i++) {
						%>


						<tr>
							<td><%=list.get(i).getBbsID()%></td>
							<td><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
		.replaceAll("\n", "<br>")%></td>
							<td><%=list.get(i).getLogId()%></td>
							<td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + " 시"
		+ list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
						</tr>

						<%
						}
						%>
					</tbody>
				</table>
				
				<a href="../bbs/bbs.jsp" class="btn btn-primary pull-right">글 보러가기</a>
			</div>

		</div>
	</form>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>