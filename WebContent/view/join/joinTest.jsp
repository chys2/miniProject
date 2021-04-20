<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=1,initial-scale=1,user-scalable=1" />

<title>회원가입</title>
<link
	href="http://fonts.googleapis.com/css?family=Lato:100italic,100,300italic,300,400italic,400,700italic,700,900italic,900"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="assets/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="assets/css/styles.css" />
<style>
body {
	background: url(../join/assets/images/join_background.jpg) no-repeat
		center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
</style>
</head>
<body>

	<section class="container login-form">
		<section>


			<form method="post" action="joinAction.jsp" role="join">
				<img src="assets/images/join_logo.png" alt="" class="img-responsive" />
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
					<input type="text" class="form-control"
						placeholder="나이(숫자만 입력해주세요.)" name="age" maxlength="10">
				</div>



				<div class="form-group" style="text-align: center;">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <input type="radio"
							name="gender" autocomplete="off" value="남자" checked>남자
						</label> <label class="btn btn-primary"> <input type="radio"
							name="gender" autocomplete="off" value="여자">여자
						</label>
					</div>


				</div>

				<input type="submit" class="btn btn-primary form-control" valye="회원가입">



			</form>

		</section>
	</section>




	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>