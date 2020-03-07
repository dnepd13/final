<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<jsp:include page="../template/header.jsp"></jsp:include>
<h1>사이트매출현황</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

    <hr>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart1);
      google.charts.setOnLoadCallback(drawChart2);
      google.charts.setOnLoadCallback(drawChart3);
      google.charts.setOnLoadCallback(drawChart4);
      google.charts.setOnLoadCallback(drawChart5);
      //많이 판 판매자
      function drawChart5(){
    	  var jsonData5 = $.ajax({
              url: "sellerTopTen",
              type:"get",
              dataType: "json",
              async: false
              }).responseText;	
    	        var data = new google.visualization.DataTable(jsonData5);

    	        var options = {
    	          title: '상품 많이 판 판매자 TOP10'
    	        };

    	        var chart = new google.visualization.PieChart(document.getElementById('piechart3'));

    	        chart.draw(data, options);
    	      }
      
      //판매금액 탑텐
      function drawChart4(){
    	  var jsonData4 = $.ajax({
              url: "priceTopTen",
              type:"get",
              dataType: "json",
              async: false
              }).responseText;	
    	        var data = new google.visualization.DataTable(jsonData4);

    	        var options = {
    	          title: '판매 금액 높은 상품 TOP10'
    	        };

    	        var chart = new google.visualization.PieChart(document.getElementById('piechart2'));

    	        chart.draw(data, options);
    	      }
      
      //많이 판 상품
      function drawChart3(){
    	  var jsonData3 = $.ajax({
              url: "goodsTopTen",
              type:"get",
              dataType: "json",
              async: false
              }).responseText;	
    	        var data3 = new google.visualization.DataTable(jsonData3);

    	        var options3 = {
    	          title: '많이 팔린 상품 TOP10'
    	        };

    	        var chart3 = new google.visualization.PieChart(document.getElementById('piechart'));

    	        chart3.draw(data3, options3);
    	      }
      
      function drawChart2() {

          var jsonData2 = $.ajax({
              url: "monthlySalePrice",
              type:"get",
              dataType: "json",
              async: false
              }).responseText;
          
    		var data2 = new google.visualization.DataTable(jsonData2);

            var options2 = {
              title: '일일판매금액',
              hAxis: {title: '날짜',  titleTextStyle: {color: '#333'}},
              vAxis: {minValue: 0}
            };

            var chart2 = new google.visualization.AreaChart(document.getElementById('chart_div2'));
            chart2.draw(data2, options2);
          }
      
      function drawChart1() {

      var jsonData1 = $.ajax({
          url: "data",
          type:"get",
          dataType: "json",
          async: false
          }).responseText;
      
		var data1 = new google.visualization.DataTable(jsonData1);

        var options1 = {
          title: '일일접속자',
          hAxis: {title: '날짜',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0}
        };

        var chart1 = new google.visualization.AreaChart(document.getElementById('chart_div1'));
        chart1.draw(data1, options1);
      }
    </script>
    <div id="chart_div1" style="width: 500px; height: 500px;"></div>
    <div id="chart_div2" style="width: 500px; height: 500px;"></div>
    <div id="piechart" style="width: 500px; height: 500px;"></div>
    <div id="piechart2" style="width: 500px; height: 500px;"></div>
    <div id="piechart3" style="width: 500px; height: 500px;"></div>
 
    <h1>오늘의 거래 금액</h1> 
    <h2>${dailySalePrice }원</h2>
    
    <h1>오늘의 거래 횟수</h1>
    <h2>${todaySaleCount }회</h2>
    
    <h1>오늘의 취소 금액</h1>
    <h2>${dailyCancel}원</h2>
    <hr>
    <h1>이번주 거래 금액</h1>
    <h2>${thisWeekSalePrice }원</h2>
    <h1>이번주 거래 횟수</h1>
    <h2>${thisWeekSaleCount }회</h2>
    <h1>이번주 취소 금액</h1>
    <h2>${thisWeekCancel }원</h2>
    <hr>
    <h1>이번달 거래 금액</h1>
    <h2>${thisMonthSalePrice }원</h2>
    
    <h1>이번달 거래 횟수</h1>
    <h1>${thisMonthSaleCount }회</h1>
    <h1>이번달 취소 금액</h1>
    <h2>${thisMonthCancel }원</h2>
