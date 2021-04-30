<%@page import="Jdbc.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.DiaryDAO"%>
<%@ page import="vo.DiaryVo"%>
<%@ page import="java.io.PrintWriter"%>
<%
PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = null;


DiaryVo diary2 = new DiaryVo();
request.setCharacterEncoding("UTF-8");
String im_address = request.getRealPath("/diaryimages");

int maxSize =1024 *1024 *10;// 한번에 올릴 수 있는 파일 용량 : 10M로 제한
 
String name ="";
String subject ="";
 
String fileName1 ="";// 중복처리된 이름
String im_name ="";// 중복 처리전 실제 원본 이름
long fileSize =0;// 파일 사이즈
String fileType ="";// 파일 타입
MultipartRequest multi =null;

String diaryC="";
try{
    // request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
    multi =new MultipartRequest(request,im_address,maxSize,"UTF-8",new DefaultFileRenamePolicy());
     
    // form내의 input name="name" 인 녀석 value를 가져옴
 
    // name="subject" 인 녀석 value를 가져옴
    diaryC = multi.getParameter("diaryContent");     
    // 전송한 전체 파일이름들을 가져옴
    Enumeration files = multi.getFileNames();
     
    while(files.hasMoreElements()){
        // form 태그에서 <input type="file" name="여기에 지정한 이름" />을 가져온다.
        String file1 = (String)files.nextElement();// 파일 input에 지정한 이름을 가져옴
        im_name = multi.getFilesystemName(file1);
    }
}catch(Exception e){
    e.printStackTrace();
}
/* diary2.setBbsTitle(diaryT); */
diary2.setDiaryContent(diaryC);
diary2.setDiaryImagename(im_name);
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
	DiaryVo diary = new DiaryDAO().getDiary(diaryID);
	if (!logId.equals(diary.getLogId())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다')");
		script.println("location.href='diary.jsp'");
		script.println("</script>");
	} else {
		// 입력이 안 됐거나 빈 값이 있는지 체크한다
		if ( multi.getParameter("diaryContent") == null || multi.getParameter("diaryContent").equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			// 정상적으로 입력이 되었다면 글 수정 로직을 수행한다
			DiaryDAO diaryDAO = new DiaryDAO();
			
			if(im_name== null){
				DiaryVo diaryBefore = new DiaryDAO().getDiary(diaryID);
				im_name = diaryBefore.getDiaryImagename();
			}
			
			int result = diaryDAO.diaryupdate(diaryID, multi.getParameter("diaryContent"),im_name);
			
			// 데이터베이스 오류인 경우
			if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글 수정하기에 실패했습니다')");
		script.println("history.back()");
		script.println("</script>");
		// 글 수정이 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
			} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글 수정하기 성공')");
		script.println("location.href='diary.jsp'");
		script.println("</script>");
			}
		}
	}

	%>


</body>
</html>