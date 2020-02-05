<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>

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
	<input type="text" name="goods_content">
	<input type="submit" value="등록">
</form>