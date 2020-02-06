<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8" />
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta http-equiv="X-UA-Compatible" content="ie=edge" />
 <script src="https://code.jquery.com/jquery-latest.js"></script>
 <script src="${pageContext.request.contextPath}/resources/js/goodsOption.js"></script>
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
	<p>카테고리번호 : </p>
	<input type="text" name="category_no"><br><br>
	
	
	<p>옵션</p>
	<button class="addOptionBtn">옵션 추가</button>
    <ul class="optionArea">
      <li>이름 		내용		 가격		 수량 		상태</li>
    </ul>
	
	
	<input type="submit" value="등록">
</form>

</body>
</html>