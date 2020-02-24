<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%-- ${pageContext.request.contextPath} 절대경로--%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<div style="padding-top: 50px;">
<jsp:include page="template/header.jsp"></jsp:include>
</div>
<div class="row justify-content-center"  style="padding: 20px;"><h1>홈</h1></div>

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
              url: "sales/sellerTopTen",
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
              url: "sales/priceTopTen",
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
              url: "sales/goodsTopTen",
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
              url: "sales/monthlySalePrice",
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
          url: "sales/data",
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

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-11">

	<div style="margin: auto; padding: 10px;"class="container">
        <div class="row">
          <div class="col-lg">
           		<div class="card bg-primary mb-3" style="max-width: 20rem;">
					  <div class="card-header">총 회원</div>
					  <div class="card-body">
					    <h4 class="card-title">${memberCount } 명</h4>
					  </div>
				</div>
          </div>
          <div class="col-lg">
	          <div class="card bg-primary mb-3" style="max-width: 20rem;">
				  <div class="card-header">총 판매자</div>
				  <div class="card-body">
				    <h4 class="card-title">${sellerCount } 명</h4>
				  </div>
			</div>
          </div>
          <div class="col-lg">
	          <div class="card bg-primary mb-3" style="max-width: 20rem;">
				  <div class="card-header">오늘 가입자</div>
				  <div class="card-body">
				    <h4 class="card-title">${todayRegist } 명</h4>
				  </div>
			</div>
          </div>
        </div>
      </div>


	 <div class="container">
        <div class="row">
          <div class="col-lg"  id="chart_div1" style="width: 500px; height: 500px;">
            One of three columns
          </div>
          <div class="col-lg" id="chart_div2" style="width: 500px; height: 500px;">
            One of three columns
        </div>
      </div>
    </div>
    
    <div class="container">
        <div class="row">
          <div id="piechart" style="width: 380px; height: 500px;">
            One of three columns
          </div>
          <div id="piechart2" style="width: 380px; height: 500px;">
            One of three columns
        </div>
        <div id="piechart3" style="width: 380px; height: 500px;">
            One of three columns
        </div>
      </div>
    </div>
 
   <div class="container">
        <div class="row">
          <div class="col-lg">
          		<div class="card text-white bg-primary mb-3" style="max-width: 20rem;">
					  <div class="card-header">오늘의 거래 금액</div>
					  <div class="card-body">
					    <h4 class="card-title">${dailySalePrice }원</h4>
					  </div>
				</div>
				<div class="card text-white bg-success mb-3" style="max-width: 20rem;">
					  <div class="card-header">오늘의 거래 횟수</div>
					  <div class="card-body">
					    <h4 class="card-title">${todaySaleCount }회</h4>
					  </div>
				</div>
				<div class="card text-white bg-warning mb-3" style="max-width: 20rem;">
					  <div class="card-header">오늘의 취소 금액</div>
					  <div class="card-body">
					    <h4 class="card-title">${dailyCancel}원</h4>
					  </div>
				</div>
          </div>
          <div class="col-lg">
          	<div class="card text-white bg-primary mb-3" style="max-width: 20rem;">
					  <div class="card-header">이번주 거래 금액</div>
					  <div class="card-body">
					    <h4 class="card-title">${thisWeekSalePrice }원</h4>
					  </div>
				</div>
				<div class="card text-white bg-success mb-3" style="max-width: 20rem;">
					  <div class="card-header">이번주 거래 횟수</div>
					  <div class="card-body">
					    <h4 class="card-title">${thisWeekSaleCount }회</h4>
					  </div>
				</div>
				<div class="card text-white bg-warning mb-3" style="max-width: 20rem;">
					  <div class="card-header">이번주 취소 금액</div>
					  <div class="card-body">
					    <h4 class="card-title">${thisWeekCancel }원</h4>
					  </div>
				</div>
          </div>
          <div class="col-lg">
          		<div class="card text-white bg-primary mb-3" style="max-width: 20rem;">
					  <div class="card-header">이번달 거래 금액</div>
					  <div class="card-body">
					    <h4 class="card-title">${thisMonthSalePrice }원</h4>
					  </div>
				</div>
				<div class="card text-white bg-success mb-3" style="max-width: 20rem;">
					  <div class="card-header">이번달 거래 횟수</div>
					  <div class="card-body">
					    <h4 class="card-title">${thisMonthSaleCount }회</h4>
					  </div>
				</div>
				<div class="card text-white bg-warning mb-3" style="max-width: 20rem;">
					  <div class="card-header">이번달 취소 금액</div>
					  <div class="card-body">
					    <h4 class="card-title">${thisMonthCancel }원</h4>
					  </div>
				</div>
          
          </div>
        </div>
      </div>
 

   </div>
        </div>
    </div>

