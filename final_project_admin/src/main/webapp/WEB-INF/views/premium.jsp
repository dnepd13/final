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
		
	});
</script>

<h1>수수료 관리창</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

<form action="" method="post">
	<input type="number" name="premium_price" placeholder="수수료조건" required="required">
	<input type="number" name="premium_rate" placeholder="수수료율" required="required">
	<input type="submit" value="등록">	
</form>
<table class="table table-hover">
  <thead>
    <tr>
      <th width="40%">수수료 조건(원)</th>
      <th width="40%">수수료(%)</th>
      <th width="20%">수정 및 삭제</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="list" items="${list }">
    <tr>
      <th scope="row">${list.premium_price }</th>
      <td>${list.premium_rate }</td>
      <td data-premium-no="${list.premium_no}" >
   			<button type="button" class="btn-modify" >수정</button>
   			<button type="button" class="btn-delete" >삭제</button>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>