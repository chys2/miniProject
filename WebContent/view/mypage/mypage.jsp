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
<title>JSP 게시판 웹 사이트</title>
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

		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="mypagemodifyAction.jsp">
					<h3 style="">정보수정</h3>

					<%
					MemberDAO mypage = new MemberDAO();
					ArrayList<MemberVo> list = mypage.mypage("test");

					for (int i = 0; i < list.size(); i++) {
					%>
					<div class="form-group">
						<input readonly="readonly" class="form-control" placeholder="아이디"
							name="logid" maxlength="20" value=<%=list.get(i).getLogid()%>>
					</div>

					<div class="form-group">
						<input type="text" class="form-control" placeholder="비밀번호"
							name="pwd" maxlength="20" value=<%=list.get(i).getPwd()%>>
					</div>

					<div class="form-group">
						<input type="text" class="form-control" placeholder="댕댕이이름"
							name="dogname" maxlength="20" value=<%=list.get(i).getDogname()%>>
					</div>

					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일"
							name="email" maxlength="20" value=<%=list.get(i).getEmail()%>>
					</div>

					<div class="form-group">
						<input type="text" class="form-control"
							placeholder="나이(숫자만 입력해주세요.)" name="age" maxlength="10"
							value=<%=list.get(i).getAge()%>>
					</div>

					<div class="form-group" style="text-align: center;">

						<%
						if (list.get(i).getGender().equals("남자")) {
						%>

						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active"> <input
								type="radio" name="gender" autocomplete="off" value="남자" checked>남자
							</label> <label class="btn btn-primary"> <input type="radio"
								name="gender" autocomplete="off" value="여자">여자
							</label>
						</div>
						<%
						} else {
						%>
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary "> <input type="radio"
								name="gender" autocomplete="off" value="남자">남자
							</label> <label class="btn btn-primary active"> <input
								type="radio" name="gender" autocomplete="off" value="여자" checked>여자
							</label>
						</div>

						<%
						}
						%>
					</div>

					<input type="submit" class="btn btn-primary form-control"
						value="정보수정"> <br><br>
					<input type="button"	class="btn btn-primary form-control"
					value= "수정취소" onclick=back()>		
					
								
				</form>
				<%
				}
				%>
			</div>
		</div>

		<div class="col-lg-4"></div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>