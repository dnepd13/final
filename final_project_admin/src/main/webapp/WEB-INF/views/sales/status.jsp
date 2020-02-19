<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<h1>사이트매출현황</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
		
      function drawChart() {

      var jsonData = $.ajax({
          url: "data",
          type:"get",
          dataType: "json",
          async: false
          }).responseText;
      
		var data = new google.visualization.DataTable(jsonData);

        var options = {
          title: 'Company Performance',
          hAxis: {title: '일일접속자',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
    <div id="chart_div" style="width: 50%; height: 500px;"></div>
