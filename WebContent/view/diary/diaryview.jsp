<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.DiaryVo"%>
<%@ page import="dao.DiaryDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
<meta name="viewprot" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>강아지의 일기</title>
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
	int diaryID = 0;
	if (request.getParameter("diaryID") != null) {
		diaryID = Integer.parseInt(request.getParameter("diaryID"));
	}
	if (diaryID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않는 글 입니다.')");
		script.println("location.href ='diary.jsp'");
		script.println("</script>");
	}
	DiaryVo diary = new DiaryDAO().getDiary(logId);
	%>
	<jsp:include page="/include/top_menu_2.jsp" flush="false" />

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
						<%-- <tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= diary.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tr> --%>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=diary.getLogId()%></td>

						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%=diary.getDiaryDate().substring(0, 11) + diary.getDiaryDate().substring(11, 13) + " 시"
		+ diary.getDiaryDate().substring(14, 16) + "분"%></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;"><%=diary.getDiaryContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
		.replaceAll("\n", "<br>")%></td>

						</tr>

						<%
							if (diary.getDiaryImagename() != null) {
						%>
						<tr>
							<td>그림</td>
							<td colspan="2" style="min-height: 200px;"><img
								src="../../diaryimages/<%=diary.getDiaryImagename()%>" /></td>

						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<a href="diary.jsp" class="btn btn-primary">목록</a>
				<%
					if (logId != null && logId.equals(diary.getLogId())) {
				%>

				<a href="diaryupdate.jsp?diaryID=<%=diaryID%>"
					class="btn btn-primary">수정</a> 
					<a onclick="return confirm('정말로 삭제하시겠습니까?')"
					href="diarydeleteAction.jsp?diaryID=<%=diaryID%>"
					class="btn btn-primary">삭제</a>

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