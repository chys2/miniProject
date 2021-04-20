<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.BbsDAO"%>
<%@ page import="vo.BbsVo"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*, java.util.*" %>
<%
BbsVo bbs = new BbsVo();
request.setCharacterEncoding("UTF-8");

 String im_address = request.getRealPath("/bbsimages");
 
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
bbs.setBbsImagename(im_name); 
System.out.println(bbs.getBbsTitle());
System.out.println(bbs.getBbsContent());
System.out.println(bbs.getBbsImagename());
%>
<%-- <jsp:useBean id="bbs" class="vo.BbsVo" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />  --%>
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
	}else{
		if (bbs.getBbsTitle().equals("") || bbs.getBbsContent().equals("") || 
				bbs.getBbsTitle() == null || bbs.getBbsContent()==null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} 
		else {

			BbsDAO bbsDAO = new BbsDAO();


			int result = bbsDAO.bbswrite(bbs.getBbsTitle(),logId,bbs.getBbsContent(),bbs.getBbsImagename());

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