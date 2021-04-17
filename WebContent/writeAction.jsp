<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="dao.BbsDAO"%>
<%@ page import="vo.BbsVo"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*, java.util.*" %>

<%-- <jsp:useBean id="bbs" class="vo.BbsVo" scope="page" /> --%>
<%
BbsVo bbs = new BbsVo();
request.setCharacterEncoding("UTF-8");

String im_address = request.getRealPath("/images");
 
int maxSize =1024 *1024 *10;// 한번에 올릴 수 있는 파일 용량 : 10M로 제한
 
String name ="";
String subject ="";
 
String fileName1 ="";// 중복처리된 이름
String im_name ="";// 중복 처리전 실제 원본 이름
long fileSize =0;// 파일 사이즈
String fileType ="";// 파일 타입
MultipartRequest multi =null;
String bbsT="";
String bbsC="";
try{
    // request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
    multi =new MultipartRequest(request,im_address,maxSize,"UTF-8",new DefaultFileRenamePolicy());
     
    // form내의 input name="name" 인 녀석 value를 가져옴
    bbsT = multi.getParameter("bbsTitle");
    // name="subject" 인 녀석 value를 가져옴
    bbsC = multi.getParameter("bbsContent");     
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
bbs.setBbsTitle(bbsT);
bbs.setBbsContent(bbsC);
bbs.setIm_name(im_name);

%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<script type="text/javascript"></script>
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
	 String saveDir = application.getRealPath("/images");
	File dir = new File(saveDir);
	
	String fName[] = dir.list();
	
	for(String fileName : fName )
	{
		out.write("<a href=\"" + request.getContextPath() + "/Download?filename=" + java.net.URLEncoder.encode(fileName, "UTF-8") + "\">" + fileName + "</a><br>");
	}

	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	if (logId == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href ='login.jsp'");
		script.println("</script>");
	}else{
	if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else { 

			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(),logId,bbs.getBbsContent(),bbs.getIm_name());
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
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}

		} 
	}

	
	%>


</body>
</html>