<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.DiaryDAO"%>
<%@ page import="vo.DiaryVo"%>
<%@ page import="java.io.PrintWriter"%>
<%request.setCharacterEncoding("UTF-8"); %>
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
#bbsForm {
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
	if(session.getAttribute("logId") != null){
		logId = (String)session.getAttribute("logId");
	}
	if(logId == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='../login/login.jsp'");
		script.println("</script>");
	}
	int diaryID = 0;
	
	if(request.getParameter("diaryID") != null){
		diaryID = Integer.parseInt(request.getParameter("diaryID"));
	}
 	if(diaryID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글2입니다')");
		script.println("location.href='diary.jsp'");
		script.println("</script>");
	} 
 	
	//해당 'diaryID'에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크한다
	DiaryVo diary = new DiaryDAO().getDiary(diaryID);
	if(! logId.equals(diary.getLogId())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다')");
		script.println("location.href='diary.jsp'");
		script.println("</script>");
	} 
%>
<jsp:include page="/include/top_menu_2.jsp" flush="false"/>
<!-- 네비게이션 영역 끝 -->

<!-- 게시판 메인 페이지 영역 시작 -->
<div id="bbsForm" >
	<div class="container" style="width:70%">
	<div class="row">
		<form method="post" action="diaryupdateAction.jsp?diaryID=<%=diaryID%>" enctype="multipart/form-data">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<!-- 테스트 코드 -->
					<%-- 	<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle() %>"></td>
						</tr> --%>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="diaryContent" maxlength="204" style="height: 350px;"><%=diary.getDiaryContent() %></textarea></td>
						</tr>							
					
				<tr>
			<td><input type="file" class="form-control"  name="diaryimages" size="40"><%=diary.getDiaryImagename() %></td>
			</tr>
			</tbody>
			</table>
			<!-- 글쓰기 버튼 생성 -->
			<a href="dairy.jsp"  class="btn btn-primary pull-right">수정취소</a>
			<input type="submit"   style="margin-right:5px " class="btn btn-primary pull-right" value="수정하기">
			
		</form>
	</div>
</div>
<!-- 게시판 메인 페이지 영역 끝 -->
</div>

<!-- 부트스트랩 참조 영역 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>