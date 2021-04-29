<%@page import="java.net.URLEncoder"%>
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
<title>강아지의 친구 글쓰기</title>
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
}
</style>
</head>

<body>
	<%
		String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}else if(session.getAttribute("logId") == null){
		String msg ="로그인을 먼저 해주세요.";
		msg=URLEncoder.encode(msg,"UTF-8");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 먼저해주세요.')");
		script.println("location.href='../login/login.jsp'");
		script.println("</script>");
		
	}
	%>
	<jsp:include page="/include/top_menu_3.jsp" flush="false" />
	<div id="bbsForm">
		<div class="container" style="width: 70%">
			<div class="row">

				<form method="post" action="bbswriteAction.jsp"
					enctype="multipart/form-data">


					<table class="table table-striped"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th 
									style="background-color: #eeeeee; text-align: center;">게시판
									글쓰기 양식</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control"
									placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
							</tr>

							<tr>
								<td><textarea class="form-control" placeholder="글 내용(제한글자수 350자)"
										name="bbsContent" maxlength="350" style="height: 270px;"></textarea>
								</td>
							</tr>
							<tr><td>	<input type="file" class="form-control" name="bbsimages" size="40">
							</td>
							</tr>
						</tbody>
					</table>
					
					<div style="margin-top:5px">
					<a href="bbs.jsp" class="btn btn-danger pull-right" style="margin-top:5px;">글쓰기 취소</a> <input
						type="submit" style="margin:5px;"
						class="btn btn-primary pull-right" value="글쓰기">
					</div>
				</form>
			</div>

		</div>

	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>

</html>