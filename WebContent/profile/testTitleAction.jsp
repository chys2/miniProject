<%@page import="vo.TitleimageVo"%>
<%@page import="vo.MemberVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.MemberDAO"%>
<%@page import="dao.BbsDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="dao.TitleImageDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="vo.BbsVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
TitleImageDAO title = new TitleImageDAO();
request.setCharacterEncoding("UTF-8");

String im_address = request.getRealPath("/profile");

int maxSize = 1024 * 1024 * 10;// 한번에 올릴 수 있는 파일 용량 : 10M로 제한

String name = "";
String subject = "";

String fileName1 = "";// 중복처리된 이름
String im_name = "";// 중복 처리전 실제 원본 이름
long fileSize = 0;// 파일 사이즈
String fileType = "";// 파일 타입
MultipartRequest multi = null;
String bbsT = "";
String titleimage = "";
try {
	// request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
	multi = new MultipartRequest(request, im_address, maxSize, "UTF-8", new DefaultFileRenamePolicy());

	// name="subject" 인 녀석 value를 가져옴
	titleimage = multi.getParameter("titleimages");
	// 전송한 전체 파일이름들을 가져옴
	Enumeration files = multi.getFileNames();

	while (files.hasMoreElements()) {
		// form 태그에서 <input type="file" name="여기에 지정한 이름" />을 가져온다.
		String file1 = (String) files.nextElement();// 파일 input에 지정한 이름을 가져옴
		im_name = multi.getFilesystemName(file1);
	}
} catch (Exception e) {
	e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	} else {
		TitleImageDAO titledao = new TitleImageDAO();
		ArrayList<vo.TitleimageVo> check = titledao.titlecheck(logId);

		if (title.view(logId).equals("foot.jpg")) {

			int result = title.insert((String) session.getAttribute("logId"), im_name);
			if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글쓰기에 실패했습니다.')");
		script.println("history.back()");
		script.println("</script>");
			}

			else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미지를 등록하였습니다.')");
		script.println("history.go(-1)");
		script.println("location.href = location.href");
		script.println("</script>");
			}

		}

		else {
			int result = title.update(logId, im_name);
			if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글쓰기에 실패했습니다.')");
		script.println("history.back()");
		script.println("</script>");
			}

			else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미지를 수정하였습니다.')");
		script.println("history.back()");
		script.println("location.href = location.href");
		script.println("</script>");
			}
		}
	}
	%>
</body>
</html>