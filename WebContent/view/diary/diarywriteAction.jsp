<%@page import="Jdbc.JdbcUtil"%>
<%@page import="javax.script.ScriptException"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.ScriptEngineManager"%>
<%@page import="vo.MemberVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.MemberDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.DiaryDAO"%>
<%@ page import="vo.DiaryVo"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.PrintWriter"%>


<%
PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = null;

DiaryVo diary = new DiaryVo();
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
String diaryT="";
String diaryC="";
try{
    // request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
    multi =new MultipartRequest(request,im_address,maxSize,"UTF-8",new DefaultFileRenamePolicy());
     
    // form내의 input name="name" 인 녀석 value를 가져옴
   /*  diaryT = multi.getParameter("bbsTitle"); */
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
/* bbs.setBbsTitle(bbsT); */
diary.setDiaryContent(diaryC);
diary.setDiaryImagename(im_name);

%>
<%-- <jsp:useBean id="bbs" class="vo.BbsVo" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" /> --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
<link rel = "stylesheet" href = "/Struts2Board/board/css.css" type = "text/css">
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
	}else{
	
		if  (diary.getDiaryContent().equals("") ||	diary.getDiaryContent()==null || diary.getDiaryImagename()==null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {

			DiaryDAO diaryDAO = new DiaryDAO();


			int result = diaryDAO.diarywrite(logId,diary.getDiaryContent(),diary.getDiaryImagename());
			
      
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
				script.println("alert('글을 작성하였습니다.')");
				script.println("location.href='diary.jsp'");
				script.println("</script>");
			}
			diaryDAO.close();
		}

	}

	%>


</body>
</html>