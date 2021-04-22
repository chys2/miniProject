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
</style>
</head>
<body>
<jsp:include page="/include/top_menu_4test.jsp" flush="false" />
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
	DiaryDAO diaryDAO = new DiaryDAO();
	ArrayList<DiaryVo> check = diaryDAO.diarycheck(logId);
	
	if(check.size() == 0) {
	%>		
		<form id="diaryForm">
			<div class="container" style="width: 70%">
				<div class="row">
					<div class="col-sm-10 col-md-10">
						<div class="thumbnail">
							<img src="../../diaryimages/foot.jpg" alt="...">
							<div class="caption" style="text-align: center">
								<h4>등록된 게시물이 없습니다.</h4>
								<p>게시물을 등록해주세요.</p>
								<p>	<a href="addDiary2.jsp" class="btn btn-primary" role="button">게시물 등록</a>
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
						<thead>
							<tr>
								<!-- <th style="background-color: #eeeeee; text-align: center">번호</th> -->
								<!-- <th style="background-color: #eeeeee; text-align: center">제목</th> -->
								<th style="background-color: #eeeeee; text-align: center">작성자</th>
								<th style="background-color: #eeeeee; text-align: center">작성일</th>
							</tr>
						</thead>
						<tbody>		
	<%
		ArrayList<DiaryVo> list = diaryDAO.getList(logId, pageNumber);
		for (int i = 0; i < list.size(); i++) {
	%>
							<tr>
								<td><%=list.get(i).getLogId()%></td>
								<td><%=list.get(i).getDiaryDate().substring(0, 11) + list.get(i).getDiaryDate().substring(11, 13) + " 시"
									+ list.get(i).getDiaryDate().substring(14, 16) + "분"%></td>
							</tr>			
	<%		
		}
	%>
						</tbody>
					</table>
					
	<%
		if (pageNumber != 1) {
	%>
					<a href="diary.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
	<%
		}
		if (diaryDAO.diarynextPage(pageNumber + 1)) {
	%>
					<a href="diary.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음</a>
	<%
		}
	%>
					<a href="diarywrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
				</div>
			</div>
		</form>
	<%	
	}	
	%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>

