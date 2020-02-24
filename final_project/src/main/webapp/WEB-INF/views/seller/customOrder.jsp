<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    

<h3>판매자 주문제작 seller/customOrder.jsp</h3>
<br><br>
<h3>견적서</h3>
<div>
	<form action="customOrder" method="post" enctype="multipart/form-data"
				onsubmit="return confirm('추후 요청자가 확인하지 않은 견적서만 삭제할 수 있습니다. 견적서를 보내시겠습니까?');">
		<input type="hidden" name="category_no" value=${category_no }>
		<input type="hidden" name="member_no" value="${member_no }">
		<input type="text" name="custom_order_title" placeholder="견적서 제목" required>
		<h5>견적서의 상세내용을 작성해주세요.</h5>
		<textarea name="custom_order_content" required></textarea>
		<h5>희망 견적은 얼마인가요?</h5>
		<input type="number" name="custom_order_price" placeholder="원">
		<h5>언제까지 가능한가요?</h5>
		<input type="date" name="custom_order_hopedate" required>
		<h5>샘플 디자인 등이 있다면 업로드해주세요.</h5>
		<input type="file" name="files" multiple>
		<br><br>
		<input type="submit" value="견적서 보내기">
	</form>
</div>
