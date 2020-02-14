<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h3>판매자 주문제작 seller/customOrder.jsp</h3>
<br><br>
<h3>견적서</h3>
<div>
	<form action="customOrder" method="post" enctype="multipart/form-data">
		<input type="hidden" name="member_no" value="${member_no }">
		<input type="text" name="custom_order_title" placeholder="견적서 제목" required>
		<h5>견적서의 상세내용을 작성해주세요.</h5>
		<textarea name="custom_order_content" required></textarea>
		<h5>희망 견적은 얼마인가요?</h5>
		<input type="number" name="custom_order_price" placeholder="원">
		<h5>작업 날짜는 언제인가요? (00월 00일까지, 다음주 수요일 등)</h5>
		<input type="text" name="custom_order_hopedate" required>
		<h5>샘플 디자인 등이 있다면 업로드해주세요.</h5>
		<input type="file" name="files" multiple>
		<br><br>
		<input type="submit" value="견적서 보내기">
	</form>
</div>
