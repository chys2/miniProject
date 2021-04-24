<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="vo.MemberVo"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="member" class="vo.MemberVo" scope="page" />
<jsp:setProperty name="member" property="logid" />
<jsp:setProperty name="member" property="pwd" />
<jsp:setProperty name="member" property="dogname" />
<jsp:setProperty name="member" property="email" />
<jsp:setProperty name="member" property="gender" />
<jsp:setProperty name="member" property="age" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
<meta name="viewprot" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>마이페이지</title>
</head>
<script>
function back(){
	history.back();
}
</script>
<body>
	<jsp:include page="/include/top_main.jsp" flush="false" />
	<%
		String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	%>

	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="col-sm-2"></div>
				<div class="col-sm-8">
					<h2 class="text-center">회원 정보 수정하기</h2>
					<form method="post" action="mypagemodifyAction.jsp">

						<%
							MemberDAO mypage = new MemberDAO();
						ArrayList<MemberVo> list = mypage.mypage(logId);

						for (int i = 0; i < list.size(); i++) {
						%>
						<table class="table table-striped">
							<tr>
								<td class="text-center">아이디</td>
								<td><input readonly="readonly" class="form-control"
									placeholder="아이디" name="logid" maxlength="20"
									value=<%=list.get(i).getLogid()%>></td>

							</tr>

							<tr>
								<td class="text-center">비밀번호</td>
								<td><input type="text" class="form-control"
									placeholder="비밀번호" name="pwd" maxlength="20"
									value=<%=list.get(i).getPwd()%>></td>
							</tr>

							<tr>
								<td class="text-center">댕댕이이름</td>
								<td><input type="text" class="form-control"
									placeholder="댕댕이이름" name="dogname" maxlength="20"
									value=<%=list.get(i).getDogname()%>></td>
							</tr>

							<tr>
								<td class="text-center">이메일</td>
								<td><input type="email" class="form-control"
									placeholder="이메일" name="email" maxlength="20"
									value=<%=list.get(i).getEmail()%>></td>
							</tr>

							<tr>
								<td class="text-center">나이</td>
								<td><input type="text" class="form-control"
									placeholder="나이(숫자만 입력해주세요.)" name="age" maxlength="10"
									value=<%=list.get(i).getAge()%>></td>
							</tr>




							<%
								if (list.get(i).getGender().equals("남자")) {
							%>

							<tr>
								<td class="text-center">성별</td>
								<td>

									<div class="btn-group" data-toggle="buttons"
										style="margin-left: 95px">
										<label class="btn btn-primary active"> <input
											type="radio" name="gender" autocomplete="off" value="남자"
											checked>남자
										</label> <label class="btn btn-primary"> <input type="radio"
											name="gender" autocomplete="off" value="여자">여자
										</label>

									</div>

								</td>
							</tr>




							<%
								} else {
							%>

							<tr>
							<td class="text-center">성별</td>
							
								<td>

									<div class="btn-group" data-toggle="buttons"
										style="margin-left: 95px">
										<label class="btn btn-primary active"> <input
											type="radio" name="gender" autocomplete="off" value="남자"
											checked>남자
										</label> <label class="btn btn-primary"> <input type="radio"
											name="gender" autocomplete="off" value="여자">여자
										</label>

									</div>

								</td>
							</tr>


							<%
								}
							%>
                           

							<tr>
								<td colspan="2" class="text-center"><input type="submit"
									class="btn btn btn-success" value="정보수정">
									&nbsp;&nbsp;&nbsp; <input type="button"
									class="btn btn btn-warning" value="수정취소" onclick=back()>


									<%
										}
									%></td>
							</tr>
						</table>

					</form>

				</div>
			</div>
			<!-- col-sm-12 -->
		</div>
		<!-- row -->
	</div>
	<!-- container end-->


	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>