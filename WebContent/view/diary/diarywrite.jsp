<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
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
#diaryForm {
padding-top:5%;
	height: 85%;
	width: 80%;
	float:right;
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
	%>
	<jsp:include page="/include/top_menu_2.jsp" flush="false"/>
	<div id="diaryForm">
	<div class="container" style="width:70%" >
		<div class="row">

			<form method="post" action="diarywriteAction.jsp" enctype="multipart/form-data">


				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"	style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<!-- <tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
							</tr> -->
							
							<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="diaryContent" maxlength="2048" style="height:270px;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				 <input type="file" class="form-control"  name="diaryimages" size="40">
				<a href="diary.jsp" class="btn btn-primary pull-right">글쓰기 취소</a>
				
				<input type="submit" style="margin-right:5px " class="btn btn-primary pull-right" value="글쓰기">
				
			</form>
		</div>

	</div>
	
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
	
</html>