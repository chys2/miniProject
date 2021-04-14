<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
<meta name="viewprot" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<jsp:include page="../include/top_main.jsp" flush="false"/>
	<div class="container">

		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="joinAction2.jsp">
					<h3 style="">회원가입</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디"
							name="logid" maxlength="20">
					</div>

					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호"
							name="pwd" maxlength="20">
					</div>

					<div class="form-group">
						<input type="text" class="form-control" placeholder="댕댕이이름"
							name="dogname" maxlength="20">
					</div>

					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일"
							name="email" maxlength="20">
					</div>

					<div class="form-group">
						<input type="text" class="form-control" placeholder="나이(숫자만 입력해주세요.)"
							name="age" maxlength="10">
					</div>



					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active"> <input
								type="radio" name="gender" autocomplete="off" value="남자"
								checked>남자
							</label> <label class="btn btn-primary"> <input type="radio"
								name="gender" autocomplete="off" value="여자" >여자
							</label>
						</div>


					</div>

					<input type="submit" class="btn btn-primary form-control"
						value="회원가입">



				</form>
			</div>
		</div>

		<div class="col-lg-4"></div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>