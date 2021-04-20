<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>등록된 게시물 없을 때 이미지</title>
<meta charset="utf-8">
<link rel="stylesheet" href="css/bootstrap.css">
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

#bbsForm {
	padding-top: 5%;
	height: 85%;
	width: 80%;
	float: right;
	background: yellow;
	padding-left: 10%;
}
</style>

</head>
<body>
	<jsp:include page="/include/top_menu_2.jsp" flush="false" />
	
	
	<form id="bbsForm">
		<div class="container" style="width: 70%">
			<div class="row">
				
				
				<div class="col-sm-10 col-md-10">
					<div class="thumbnail">
						<img src="../../diaryimages/foot.jpg" alt="...">
						<div class="caption" style="text-align: center">
							<h4>등록된 게시물이 없습니다.</h4>
							<p>게시물을 등록해주세요.</p>
						
							<p>
								<a href="addDiary2.jsp" class="btn btn-primary" role="button">게시물
									등록</a>
							</p>
							
						</div>
					</div>
				</div>
				
				
			</div>
		</div>
	</form>
</body>
</html>
