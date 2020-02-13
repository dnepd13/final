<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
<script>

</script>

<h3>회원 구매자 주문제작 member/customOrder.jsp</h3>
<br><br>
<h3>요청서</h3>

<!-- 카테고리 선택페이지 -->
<div>
	<h5>요청서를 보낼 기본 카테고리를 선택해주세요.</h5>
	<select class="cate_large">	</select>
	<select class="cate_middle"></select>
	<select class="cate_small"></select>
	<input type=submit value="선택">
</div>
<br>
<!-- 요쳥서 작성페이지: hidden 값은 나중에 회원/판매자에서 정보 가져오기 -->
<div>
	<form action="customOrder" method="post" enctype="multipart/form-data">
		<input type="hidden" name="seller_no" value="${seller_no }">
		<input type="text" name="custom_order_title" placeholder="요청서 제목" required>
		<h5>요청하는 상세내용을 작성해주세요.</h5>
		<textarea name="custom_order_content" required></textarea>
		<h5>희망 가격은 얼마인가요?</h5>
		<input type="number" name="custom_order_price" placeholder="원" required>
		<h5>희망 기한은 언제인가요? (00월 00일까지, 다음주 수요일 등)</h5>
		<input type="text" name="custom_order_hopedate" required>
		<h5>원하는 디자인 등이 있다면 업로드해주세요.</h5>
		<input type="file" name="files" multiple>
		<br><br>
		<input type="submit" value="요청서 보내기">
	</form>
</div>
