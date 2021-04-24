<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.DiaryDAO"%>
<%@ page import="vo.DiaryVo"%>
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

#diaryForm {
	padding-top: 5%;
	height: 85%;
	width: 80%;
	float: right;
	background: yellow;
}

#diaryForm_2 {
	padding-left: 10%;
	padding-top: 5%;
	height: 85%;
	width: 80%;
	float: right;
	background: yellow;
}
</style>
</head>
<body>



	<jsp:include page="/include/top_menu_2.jsp" flush="false" />


	<%

	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	
	DiaryVo diary = new DiaryDAO().getDiary(logId); 
	DiaryDAO diaryDAO = new DiaryDAO();
	 ArrayList<DiaryVo> check = diaryDAO.diarycheck(logId); 
	ArrayList<DiaryVo> list = diaryDAO.getDiarylist(logId);
	
	
	if(check.size() == 0) {
	%>
	<form id="diaryForm_2">
		<div class="container" style="width: 70%">
			<div class="row">
				<div class="col-sm-10 col-md-10">
					<div class="thumbnail">
						<img src="../../diaryimages/foot.jpg" alt="...">
						<div class="caption" style="text-align: center">
							<h4>등록된 게시물이 없습니다.</h4>
							<p>게시물을 등록해주세요.</p>
							<p>
								<a href=diarywrite.jsp class="btn btn-primary" role="button">게시물
									등록</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>

	<%
	} else {
	%>


	<form id="diaryForm">
		<div class="container" style="width: 70%">
			<div class="row">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">



					<%if(diary.getDiaryImagename()!=null){ 
					%>
					<tr>
						
						<td colspan="2" style="min-height: 200px;"><img
							src="../../diaryimages/<%=diary.getDiaryImagename()%>" /></td>

					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=diary.getDiaryDate().substring(0, 11) + diary.getDiaryDate().substring(11, 13) + " 시"
									+ diary.getDiaryDate().substring(14, 16) + "분"%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= diary.getDiaryContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></td>

					</tr>
					
				</table>
				
				

<%
System.out.println("아이디 확인");

System.out.println(logId);
System.out.println("아이디 확인2");
				
			if(logId != null && logId.equals(diary.getLogId())){
			%>

				<a href="diaryupdate.jsp?diaryID=<%=diary.getDiaryId()%>"
					class="btn btn-primary">수정</a> <a
					onclick="return confirm('정말로 삭제하시겠습니까?')"
					href="diarydeleteAction.jsp?diaryID=<%=diary.getDiaryId()%>"
					class="btn btn-primary">삭제</a>

				<% 
			}
			%>
				<a href="diarywrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
				
			</div>
		</div>
	</form>
	<%	
	}}	
	%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>

