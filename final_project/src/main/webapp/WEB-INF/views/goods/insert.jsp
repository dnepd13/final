<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8" />
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta http-equiv="X-UA-Compatible" content="ie=edge" />
 <script src="https://code.jquery.com/jquery-latest.js"></script>
 <script src="${pageContext.request.contextPath}/resources/js/goodsOption.js"></script>
 <script>
 	 $(function(){
////////////	카테고리	///////////////////////////////////
 		 var category_largeList = "${category_largeList}";
	 	 category_largeList = category_largeList.substring(1, category_largeList.length-1).split(",");
 		 $.each(category_largeList, function(index, item){
 			 var option = $("<option value='"+item+"'>"+item+"</option>");
 			 $(".category_large").append(option);
 		 });
 		 
 		 $(".category_large").change(function(){
	 		 $(".middleChild").nextAll().remove();
	 		 $(".smallChild").nextAll().remove();
 			 var category_name = $(this).val();
 			 var url = "large";
 			 $.ajax({
 				 type: "POST",
 			 	 url: url,
 			 	 data: {"category_name":category_name},
 			 	 success: function(resp){
 			 		 $.each(resp, function(index, item){
 			 			var option = $("<option value='"+item+"'>"+item+"</option>");
 			 			$(".category_middle").append(option);
 			 		 });
 			 	 }
 			 });
 		 });
 		 
 		 $(".category_middle").change(function(){
 			$(".smallChild").nextAll().remove();
			 var category_name = $(this).val();
			 var url = "middle";
			 $.ajax({
				 type: "POST",
			 	 url: url,
			 	 data: {"category_name":category_name},
			 	 success: function(resp){
			 		 $.each(resp, function(index, item){
			 			var option = $("<option value='"+item+"'>"+item+"</option>");
			 			$(".category_small").append(option);
			 		 });
			 	 }
			 });
 		 });
 		 
 		 $(".category_small").change(function(){
 			var category_name = $(this).val();
			 var url = "small";
			 $.ajax({
				 type: "POST",
			 	 url: url,
			 	 data: {"category_name":category_name},
			 	 success: function(resp){
		 			 $(".category_no").val(resp);
			 	 }
			 });
 		 });
//////////////////////////////////////////////////////////////////////		 
 		 
 		 
	});
 </script>
</head>
<body>
<h1>상품 등록 페이지</h1>

<form action="insert" method="post">
	
	<!-- 세션에서 번호 가져와서 히든으로 넒길 거 --------------------------->
	<p>판매자 번호 </p>
	<input type="text" name="seller_no" required><br><br>
	<!-- -------------------------------------------------- -->
	
	<p>상품 이름 </p>
	<input type="text" name="goods_name" required><br><br>
	<p>상품 가격 </p>
	<input type="text" name="goods_price" required><br><br>
	<p>상품 수량 </p>
	<input type="text" name="goods_stock" required><br><br>
	<p>할인 가격 </p>
	<input type="text" name="goods_discount_price" required><br><br>
	<p>할인 시작 </p>
	<input type="date" name="goods_discount_start" required><br><br>
	<p>할인 종료 </p>
	<input type="date" name="goods_discount_finish" required><br><br>
	<p>판매 여부 </p>
	<select name="goods_status">
		<option value="Y">Y</option>
		<option value="N">N</option>
	</select><br><br>
	<p>상품 설명 : </p>
	<input type="text" name="goods_content"><br><br>
	
	<select class="category_large" name="category_middle">
			<option class="largeChild">선택</option>
	</select>
	<select class="category_middle" name="category_middle">
			<option class="middleChild">선택</option>
	</select>
	<select class="category_small" name="category_middle">
			<option class="smallChild">선택</option>
	</select>
	<input class="category_no" type="hidden" name="category_no" value="">	
		
	<p>옵션</p>
	<button class="addOptionBtn">옵션 추가</button>
    <ul class="optionArea">
      <li>이름 		내용		 가격		 수량 		상태</li>
    </ul>
	
	<hr><hr><hr>
	<h1>배송 정보 입력</h1>
	배송여부 : 
	<select name="delivery_agree">
		<option value="Y">Y</option>
		<option value="N">N</option>
	</select>
	<br>
	묶음 배송 여부 : 
	<select name="delivery_set_agree">
		<option value="Y">Y</option>
		<option value="N">N</option>
	</select>
	<br>
	묶음 배송 조건 금액 : 
	<input type="text" name="delivery_set_op_price">
	<br>
	택배 회사 : 
	<select name="delivery_company">
		<option value="우체국">우체국</option>
		<option value="한진">한진</option>
		<option value="로젠">로젠</option>
	</select>
	<br>
	배송비 : 
	<input type="text" name="delivery_price">
	<br>
	상품별 배송비 : 
	<select name="delivery_option">
		<option value="무료">무료</option>
		<option value="유료">유료</option>
		<option value="조건부무료">조건부무료</option>
	</select>
	<br>
	조건부 무료 금액 : 
	<input type="text" name="delivery_op_price">
	<br>
	반품 배송비 :
	<input type="text" name="delivery_return_price">
	<br>	
	<input type="submit" value="등록">
</form>

</body>
</html>