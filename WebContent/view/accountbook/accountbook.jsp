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

	String beforedate = request.getParameter("beforedate");
	String afterdate = request.getParameter("afterdate");
	System.out.println(logId);
	
	Calendar now  = Calendar.getInstance();
	int month = now.get(Calendar.MONTH)+1;
	AccountBookDAO book = new AccountBookDAO();
	ArrayList<AccountBookVo> list= book.getAccount(logId);
	ArrayList<AccountBookVo> listsearch= book.getSearchAccount(logId, beforedate, afterdate);
	
	
	%>
	<jsp:include page="/include/top_menu_1.jsp" flush="false" />
	<div id="accountForm">
		<div class="container" id="container">
			
			<%if(list.size() == 0){ %>
			<div  id="container_2" style="padding-top: 10%"><h2>오른쪽에서 지출 내역을 입력해주세요</h2></div>
			<!-- 가계부에 대한 데이터가 입력한 값이 없을 경우  부분-->
			<%}else { %>
			<div  id="container_2">그래프영역
			<!-- 가계부에 대한 데이터가 입력한 값이 있을 경우  밑에서 그래프를 가져와 출력하는 부분-->
			</div>

			<%} %>

			<div  id="container_3"> 
			<form action="accountinsertAction.jsp" method="post" class="account">
			
			 <div class="form-group" >
    		<input type="date" name="date" class="form-control" style="height:30px; width:150px; margin-bottom: 5px;">
			<select class="form-control"  name="account" id="account" style="height:30px; width:100px; float:left;" >
   			<option value="meal">식사비</option>
    		<option value="clothes">의류비</option>
    		<option value="hospital">병원비</option>
    		<option value="hair">뷰티비</option>
    		<option value="etc">기타</option>
			</select> 
			<input type="text" class="form-control" name="money" placeholder="금액을 입력해주세요." id="money" 
			maxlength="20" style="height:30px; width:250px; float:left; margin-left:5px;"><br>
			</div>
	
			<input type="submit" value="지출하기" class="btn" style="height:30px;">
			</form>
			<hr>
			<%	for (int i = 0; i < list.size(); i++) {
    			%>
			<b><%=list.get(i).getDogname()%></b>님을 위한 <b><%=month%></b>월 지출내역서<br>
		  &#128073; 식&nbsp;&nbsp;&nbsp;비 : <b><%=list.get(i).getMeal()%></b>원<br>
          의류비 : <b><%=list.get(i).getClothes()%></b>원<br>
          병원비 : <b><%=list.get(i).getHospital()%></b>원<br>
         뷰티비 : <b><%=list.get(i).getHair() %></b>원<br>
          기&nbsp;&nbsp; &nbsp;타 : <b><%=list.get(i).getEtc() %></b>원<br>
           총지출 : <b>  <%=list.get(i).getTotal() %></b>원<br>
			<hr>
			
			<form action="accountbook.jsp" method="post" class="account">
			<div class="form-group" >
			<input type="date" name="beforedate" class="form-control" style="height:30px; width:150px; margin-bottom: 5px;float:left;">
			<input type="date" name="afterdate" class="form-control" style="height:30px; width:150px; margin-left:5px; margin-bottom: 5px; float:left;">
			 <input type="submit" value="검색하기" class="btn" style="height:30px; margin-left:5px;">
			
			 </div>
			  검색할 날짜를 지정해주세요.
			 </form>
			
			 <%} %>
			 
			 <%if(listsearch.size()!=0 ){	
			 for (int i = 0; i < list.size(); i++) {
    			%>
			 <b><%=beforedate %></b>에서<b><%=afterdate %></b>까지 <br>
			 <b><%=listsearch.get(i).getDogname()%></b>님을 위해 <b><%=listsearch.get(i).getTotal() %></b>원을 지출했습니다.
			 
			 <% }
			
			 }else { %>
				
			 <%} %>
			</div>
			
			
			
			
			
		</div>
	</div> <!--<div id="accountForm"> 값  -->
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