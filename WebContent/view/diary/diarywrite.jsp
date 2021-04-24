<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>다이어리 등록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

#diaryForm {
	padding-left: 18%;
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
	%>
	<jsp:include page="/include/top_menu_2.jsp" flush="false" />
	<div id="diaryForm">
		<div class="contatiner" style="width: 70%">
			<div class="row">
				<form method="post" action="diarywriteAction.jsp" enctype="multipart/form-data">
					<table class="table table-striped"	style="border: 20px solid #dddddd"  style="text-align: center">
						<thead>
						<tr><th style="background-color: #eeeeee; text-align: center;">댕댕님 일기</th>	</tr>
						</thead>
						<tbody>
							<tr>
								<td> <input type="file" class="form-control"  name="diaryimages" size="40"> <br></td>
							</tr>
							<tr><td> <textarea class="form-control"	placeholder="내용을 입력해주세요." name="diaryContent" maxlength="2048"
										style="height:150px"></textarea></td></tr>

						</tbody>

					</table>
			
			
			<a href="diary.jsp" class="btn btn-danger pull-right">글쓰기 취소</a>
				
				<input type="submit" style="margin-right:5px " class="btn btn-primary pull-right" value="글쓰기">
			
				</form>
			
			</div>
			
		</div>
	</div>

</body>
</html>
