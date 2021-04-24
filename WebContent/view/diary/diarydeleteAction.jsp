<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.DiaryDAO"%>
<%@ page import="vo.DiaryVo"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">

<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	if (logId == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href ='../login/login.jsp'");
		script.println("</script>");
	}
	int diaryID = 0;
	if (request.getParameter("diaryID") != null) {
		diaryID = Integer.parseInt(request.getParameter("diaryID"));
	}
	if (diaryID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href='diary.jsp'");
		script.println("</script>");
	}

	//해당 'bbsID'에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크한다
	DiaryVo diary = new DiaryDAO().getDiary(logId);
	if (!logId.equals(diary.getLogId())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다')");
		script.println("location.href='diary.jsp'");
		script.println("</script>");
	} else {
		// 정상적으로 입력이 되었다면 글 수정 로직을 수행한다
		DiaryDAO diaryDAO = new DiaryDAO();
		System.out.println(diaryID);
		int result = diaryDAO.diarydelete(diaryID);
		// 데이터베이스 오류인 경우
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
			// 글 수정이 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제 성공')");
			script.println("location.href='diary.jsp'");
			script.println("</script>");
		}
	}
	%>


</body>
</html>