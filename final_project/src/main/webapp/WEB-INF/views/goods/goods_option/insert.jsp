<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<h1>상품 옵션 등록</h1>

<form action="insert" method="post">
	<p>상품 번호</p>
	<input type="text" name="goods_no" required><br><br>
	<p>옵션 이름 </p>
	<input type="text" name="goods_option_title" required><br><br>
	<p>옵션 내용 </p>
	<input type="text" name="goods_option_content" required><br><br>
	<p>옵션 가격 </p>
	<input type="text" name="goods_option_price" required><br><br>
	<p>옵션 수량 </p>
	<input type="text" name="goods_option_stock" required><br><br>
	<p>판매 여부 </p>
	<select name="goods_status">
		<option value="Y">Y</option>
		<option value="N">N</option>
	</select><br><br>
	<input type="submit" value="등록">
</form>

