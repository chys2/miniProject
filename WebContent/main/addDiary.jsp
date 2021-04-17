<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>등록된 게시물 없을 때 이미지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="contatiner" style="width: 60%">
		<div class="row">
			<form method="post" action="uploadDiary.jsp">
				<table class="table table-striped"
					style="border: 25px solid #dddddd">


					<thead>
					</thead>
					<tbody>

						<tr>
							<td>제목: <input type="text" class="form-control"
								placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
						</tr>

						<tr>
							<td>내용: <textarea class="form-control"
									placeholder="내용을 입력해주세요." name="diaryContent" maxlength="2048"></textarea></td>
						</tr>
						<tr>
							<td><input type="file" name="file" value="찾아보기">
							<br></td>
						</tr>
					</tbody>

				</table>
				<div class="contatiner" style="width: 70%" style="algin:center">
					<input type="submit" style="margin-left: 50%"
						class="btn btn-primary pull-center" value="등록">
						<input
						type="submit" style="margin-left: 20%" class="btn btn-secondary"
						value="취소">
				</div>

			</form>
		</div>
	</div>






</body>
</html>
