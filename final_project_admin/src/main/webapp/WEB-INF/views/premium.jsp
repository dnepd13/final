<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	$(function(){
		$(".btn-modify").click(function(){
			if($(this).text()=="수정"){
				var priceCell = $(this).parent().prev().prev();
				var rateCell = $(this).parent().prev();
				
				var price = priceCell.text();
				var rate = rateCell.text();
				
				priceCell.empty();
				rateCell.empty();
				
				$("<input>").val(price).appendTo(priceCell);
				$("<input>").val(rate).appendTo(rateCell);
				
				$(this).text("완료");
			}
			else{
				var priceCell = $(this).parent().prev().prev();
				var rateCell = $(this).parent().prev();
				
				var price = priceCell.children().val();
				var rate = rateCell.children().val();
				
				var upprice = $(this).parent().parent().prev().prev();
				var downprice = $(this).parent().parent().next();
				
				console.log(upprice);
				console.log(downprice);
				priceCell.empty();
				rateCell.empty();
				
				priceCell.text(price);
				rateCell.text(rate);
				
				$(this).text("수정");
				
				var premium_price = priceCell.text();
				var premium_rate = rateCell.text();
				
				var td = $(this).parent();
				var premium_no = td.data("premium-no");
				
				$.ajax({
					url:"premiumUpdate",
					type:"post",
					data:{
						"premium_no":premium_no,
						"premium_price":premium_price,
						"premium_rate":premium_rate
					},
					success:function(resp){
						console.log(resp);
					}
				});
			}
		});
		
		$(".btn-delete").click(function(){
			$(this).parent().parent().remove();
			
			var td = $(this).parent();
			var premium_no = td.data("premium-no");
			
			$.ajax({
				url:"premiumDelete",
				type:"post",
				data:{
					"premium_no":premium_no
				},
				success:function(resp){
					console.log(resp);
				}
			})
		});
		
		
		
		$(".btn").click(function(){
			var premiumprice = $(".preminumPrice").val();
			var premiumrate = $(".preminumRate").val();
			console.log("premiumprice"+premiumprice);
			var tr = $('.table').find('tr').length;
			console.log(tr);
			if(tr == 1 ){
				$(".premiumForm").submit();
			}
			else{
			$(".premium").each(function(){
				var premium = $(this).text();
				
				if(premiumprice == parseInt(premium)){
					window.alert("이미 존재하는 값입니다");
					return false
				}
				else{
					if(premiumprice > parseInt($(this).text())){
						console.log(premiumprice);
						console.log($(this).text());
// 						var thisrate = parseInt($(this).next().text());
// 						var nextrate = parseInt($(this).parent().prev().children(".rate").text());
						
// 						console.log($(this).next().text());
// 						console.log($(this).parent().prev().children(".rate").text());
// 						console.log(premiumrate);
						if(premiumrate < parseInt(thisrate)){
							if($(this).parent().prev().children(".rate").length == 0){
								$(".premiumForm").submit();
								return false;
							}
							else if(premiumrate > nextrate){
								$(".premiumForm").submit();
								return false;
							}
							else{
								window.alert("수수료율이나 수수료 조건을 다시 입력하세요");
								return false;
							}
						}
						else{
							window.alert("수수료를 다시 입력해주세요.");
							return false;
						}
					}
				}
			 });
			}
			
		});
		
	});
</script>

<style>
	.arti{
		overflow: hidden;
	}
</style>

<aside>
<div>
<jsp:include page="template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article class="arti">

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;">
<h1>수수료 관리창</h1>
</div>

<form class="premiumForm" action="" method="post">
	<input class="preminumPrice" type="number" name="premium_price" placeholder="수수료조건" required="required">
	<input class="preminumRate" type="number" name="premium_rate" placeholder="수수료율" required="required">
	<input class="btn" type="button" value="등록">	
</form>
<table class="table table-hover">
  <thead>
    <tr class="em">
      <th width="40%">수수료 조건(원)</th>
      <th width="40%">수수료(%)</th>
      <th width="20%">수정 및 삭제</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="list" items="${list }">
    <tr class="em">
      <th scope="row" class="premium">${list.premium_price }</th>
      <td class="rate">${list.premium_rate }</td>
      <td data-premium-no="${list.premium_no}" >
   			<button type="button" class="btn-modify" >수정</button>
   			<button type="button" class="btn-delete" >삭제</button>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</div>
        </div>
    </div>
    </article></section>