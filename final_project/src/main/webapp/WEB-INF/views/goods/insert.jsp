<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>

<h1>��ǰ ��� ������</h1>

<form action="insert" method="post">
	
	<!-- ���ǿ��� ��ȣ �����ͼ� �������� �ϱ� �� --------------------------->
	<p>�Ǹ��� ��ȣ </p>
	<input type="text" name="seller_no" required><br><br>
	<!-- -------------------------------------------------- -->
	
	<p>��ǰ �̸� </p>
	<input type="text" name="goods_name" required><br><br>
	<p>��ǰ ���� </p>
	<input type="text" name="goods_price" required><br><br>
	<p>��ǰ ���� </p>
	<input type="text" name="goods_stock" required><br><br>
	<p>���� ���� </p>
	<input type="text" name="goods_discount_price" required><br><br>
	<p>���� ���� </p>
	<input type="date" name="goods_discount_start" required><br><br>
	<p>���� ���� </p>
	<input type="date" name="goods_discount_finish" required><br><br>
	<p>�Ǹ� ���� </p>
	<select name="goods_status">
		<option value="Y">Y</option>
		<option value="N">N</option>
	</select><br><br>
	<p>��ǰ ���� : </p>
	<input type="text" name="goods_content">
	<input type="submit" value="���">
</form>