<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.BbsVo"%>
<%@ page import="dao.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
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
	padding-top: 5%;
	height: 85%;
	width: 80%;
	float: right;
	background: yellow;
}
</style>
</head>
<body>
	<%
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않는 글 입니다.')");
		script.println("location.href ='bbs2.jsp'");
		script.println("</script>");
	}
	BbsVo bbs = new BbsDAO().getBbs(bbsID);
	%>
	<jsp:include page="../include/top_menu_3.jsp" flush="false" />

	<form id="bbsForm">
		<div class="container" style="width: 70%">
			<div class="row">

				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3"
								style="background-color: #eeeeee; text-align: center;">게시판
								글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n",
		"<br>")%></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=bbs.getLogId()%></td>

						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + " 시"
		+ bbs.getBbsDate().substring(14, 16) + "분"%></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n",
		"<br>")%></td>

						</tr>

						<%
						if (bbs.getBbsImagename() != null) {
						%>
						<tr>
							<td>그림</td>
							<td colspan="2" style="min-height: 50px;"><img
								src="../bbsimages/<%=bbs.getBbsImagename()%>" /></td>

						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<a href="bbs2.jsp" class="btn btn-primary">목록</a>
				<%
				if (logId != null && logId.equals(bbs.getLogId())) {
				%>

				<a href="update2.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')"
					href="deleteAction2.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>

				<%
				}
				%>

			</div>

		</div>
	</form>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>