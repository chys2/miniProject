<%@page import="Jdbc.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.DiaryDAO"%>
<%@ page import="vo.DiaryVo"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
<meta name="viewprot" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>강아지를 위한 일기</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

#diaryForm {
	padding-top: 5%;
	height: 85%;
	width: 80%;
	float: right;
	/* background: yellow; */
}

#diaryForm_2 {

	padding-top: 1%;
	height: 85%;
	width: 80%;
	float: left;
	/* background: yellow; */
}

* {
	/*Remove the margins of all elements*/
	/*You can remove the left margin of li in ul to make it beautiful*/
	margin: 0;
	padding: 0;
}

#div-box1 {
	width: 80%;
	height: 85%;
	text-align: center;
	margin-left: 10%;
	float: left;
}

.faceul {
	width: 100%;
	height: 550px;
	/*Make ul automatically center horizontally*/
}

#div-box1 li {
	/*Remove the style in front of li*/
	list-style-type: none;
	width: 31%;
	height: 500px;
	/* border:1px solid red; */
	/*To put li in a row, use left and left float*/
	float: left;
	margin-top: 2%;
	margin-left: 2%;
}

.faceul img {
	width: 100%;
}

.faceul span {
	display: block;
}

.faceul a:link {
	color: black;
	text-decoration: none;
}

.faceul a:hover {
	color: red;
	text-decoration: underline;
}

.info_left {
	width: 40%;
	float: left;
}

.info_right {
	width: 60%;
	float: right;
}
#content-box{

border: 1px solid #e6e6e6;
border-radius: 10px;
}

</style>
</head>
<body>

	<jsp:include page="/include/top_blank.jsp" flush="false" />


	<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Connection conn = null;
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

	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

	DiaryDAO diaryDAO = new DiaryDAO();
	ArrayList<vo.DiaryVo> diaryList = diaryDAO.getList(logId, pageNumber);

	if (diaryList.size() == 0) {
	%>
	<form id="diaryForm_2">
		<div class="container" style="width: 70%">
			<div class="row">
				<div >
					<div class="thumbnail" style="margin-left:35%;">
						<img src="../../diaryimages/foot.jpg" alt="...">
						<div class="caption" style="text-align: center">
							<h4>등록된 게시물이 없습니다.</h4>
							<p>게시물을 등록해주세요.</p>
							<p>
								<a href=../diary/diarywrite.jsp class="btn btn-primary" role="button" >등록</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>

	<%
		} else {
	%>
	
	<div id="div-box1">    	
	
		<ul class="faceul">
			<%
				for(vo.DiaryVo diary : diaryList) {
					if (diary.getDiaryImagename() != null) {
			%>
				<li>
						<div class="thumbnail">
							<img src="../../diaryimages/<%=diary.getDiaryImagename()%>" style="height: 270px"/>
						</div>
					
					
				</li>	
			<% 				
					}
				}
			%>				
		</ul>
		
		
		
	</div>
	
	

	<%

	}
	diaryDAO.close();
	%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>

