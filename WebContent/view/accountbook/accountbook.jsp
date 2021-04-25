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
	height: 85%;
	width: 80%;
	float: right;
	/* background: yellow; */
}

#container {
	/* background: yellow; */
	height: 80%;
}

#container_2 {
	  /* background: pink; */  
	height: 100%;
	width: 60%;
	float: left;
	text-align: center;
}

#container_3 {
	background: skyblue;
	height: 100%;
	width: 40%;
	float: right;
}


</style>

</head>
<body>
	<%
	String logId = null;
	if (session.getAttribute("logId") != null) {
		logId = (String) session.getAttribute("logId");
	}
	
	Calendar now  = Calendar.getInstance();
	int month = now.get(Calendar.MONTH)+1;
	AccountBookDAO book = new AccountBookDAO();
	ArrayList<AccountBookVo> list= book.getAccount(logId);
	
	
	%>
	<jsp:include page="/include/top_menu_1.jsp" flush="false" />
	<div id="accountForm">
		<div class="container" id="container">
			
			<%if(list.size() == 0){ %>
			<div  id="container_2" style="padding-top: 10%"><h2>오른쪽에서 지출 내역을 입력해주세요</h2></div>
	<%}else { %>
			<div  id="container_2">그래프영역</div>

			<%} %>

			<div  id="container_3"> 
			<form action="accountinsertAction.jsp" method="post" class="account">
			<select name="account" id="account">
   			<option name="meal" value="meal">식사비</option>
    		<option value="clothes">의류비</option>
    		<option value="hospital">병원비</option>
    		<option value="hair">뷰티비</option>
    		<option value="etc">기타</option>
			</select>
			<input type="text" name="money" placeholder="금액을 입력해주세요." maxlength="20">
			 <input type="date" name="date">
			<input type="submit" value="지출하기">
			</form>
			
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
        <%	for (int i = 0; i < list.size(); i++) {
    			%>
          ['지출품목', '지출내역'],
          ['식비',     <%=list.get(i).getMeal() %>],
          ['의류비',  <%=list.get(i).getClothes()%>   ],
          ['병원비',<%=list.get(i).getHospital() %>],
          ['뷰티비',<%=list.get(i).getHair() %>],
          ['기타',   <%=list.get(i).getEtc() %>]
        	
        ]);
       
        var options = {
          title: '<%=list.get(i).getDogname()%>님을 위한 <%=month%>월 지출내역',
         	width:'100%',
         	height :'100%'
        };
        <%}%>
        var chart = new google.visualization.PieChart(document.getElementById('container_2'));

        chart.draw(data, options);
      }
    </script>

</body>
</html>