<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="vo.MemberVo"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.AccountBookDAO"%>
<%@ page import="vo.AccountBookVo"%>
<%@ page import="java.util.ArrayList"%>
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

#accountForm {
	padding-top: 5%;
	height: 100%;
	width: 100%;
	float: right;
/* 	 background: skyblue;  */
}

#container {
	/*  background: yellow;  */
	height: 80%;
}

#container_2 {
margin-left:2.7%;
margin-top:3%;
	/* background: pink; */ 
	height: 100%;
	width: 60%;
	float: left;
	
}


</style>

</head>
<body>
	<%
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

	String beforedate = request.getParameter("beforedate");
	String afterdate = request.getParameter("afterdate");

	Calendar now = Calendar.getInstance();
	int year = now.get(now.YEAR);
	int month = now.get(Calendar.MONTH) + 1;
	int startDay = now.getActualMinimum(now.DAY_OF_MONTH);
	int endDay = now.getActualMaximum(now.DAY_OF_MONTH);
	String now_month_startDay = year + "-" + month + "-" + startDay;

	String now_month_endDay = year + "-" + month + "-" + endDay;
	System.out.println(now_month_startDay);
	System.out.println(now_month_endDay);

	AccountBookDAO book = new AccountBookDAO();
	book.change_month(logId, now_month_startDay, now_month_endDay);
	ArrayList<AccountBookVo> list = book.getAccount(logId, now_month_startDay, now_month_endDay);
	//ArrayList<AccountBookVo> list = book.getAccount("test", now_month_startDay, now_month_endDay);
	ArrayList<AccountBookVo> listsearch = book.getSearchAccount(logId, beforedate, afterdate);
	%>
	<jsp:include page="/include/top_blank.jsp" flush="false" />
	<div id="accountForm">
		<div class="container" id="container">

			<%
			if (list.size() == 0) {
			%>
			<div id="container_2" style="padding-top: 10%;  " >
				<h2><b>지출 내역이 없습니다.</b></h2>
				<br><b>지출 내역을 등록해주세요.</b>
				<br><br>
				<a href=../accountbook/accountbook.jsp class="btn btn-primary" role="button">등록</a>
			</div>
			<!-- 가계부에 대한 데이터가 입력한 값이 없을 경우  부분-->
			<%
			} else {
			%>
			<div id="container_2">
				<!-- 가계부에 대한 데이터가 입력한 값이 있을 경우  밑에서 그래프를 가져와 출력하는 부분-->
			</div>

			<%
			}
			%>

			</div>
	</div>
	<!--<div id="accountForm"> 값  -->
	<!-- 가계부에 대한 데이터 값이 있을 경우 그래프 출력 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
        <%for (int i = 0; i < list.size(); i++) {%>
          ['지출품목', '지출내역'],
          ['식비',     <%=list.get(i).getMeal()%>],
          ['의류비',  <%=list.get(i).getClothes()%>   ],
          ['병원비',<%=list.get(i).getHospital()%>],
          ['뷰티비',<%=list.get(i).getHair()%>],
          ['기타',   <%=list.get(i).getEtc()%>]
        	
        ]);
       
        var options = {
          title: '<%=list.get(i).getDogname()%>님을 위한 <%=month%>월 지출내역',
         	width:'100%',
         	height :'100%',
         		 backgroundColor: '#e1e3ef'
         
        };
        <%}%>
        var chart = new google.visualization.PieChart(document.getElementById('container_2'));
			
        chart.draw(data, options);
      }
    </script>
</body>
</html>