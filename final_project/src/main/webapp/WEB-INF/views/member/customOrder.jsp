<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
 
 <style>
 	.articleBox {
 		width: 500px;
		margin: 0 auto;
		padding: 100px 0;
	}
 	.insert_cate,
 	.insert_req  {
 		width: 90%;
 	}
 	.insert_req * {
 		width: 100%;
 	}
 	.text-primary {
 		font-weight: bold; 
 	}
 	.insert_req textarea{
 		resize: none;
 		height: 25%;
 	}
 	.insert_req input[type=submit] {
 		height: 50px;
 	}
 	.btn_next {
 		border: 1px solid darkgray;
 		background-color: white;
 	}
	.btn_next:focus {
 		outline: none;
 	}
 </style>
 
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>

</script>


<!-- 요쳥서 작성페이지: hidden 값은 나중에 회원/판매자에서 정보 가져오기 -->
<article class="articleBox infoPage-area">
<div class="insert_req">
	<form action="customOrder" method="post" enctype="multipart/form-data"
				onsubmit="return confirm('추후 판매자가 확인하지 않은 요청서만 삭제할 수 있습니다. 요청서를 보내시겠습니까?');">
		<input type="hidden" name="seller_no" value="${seller_no }">
		<h6 class="text-secondary">요청서 제목을 작성해주세요.</h6>
		<input class="input_req form-control" type="text" name="custom_order_title" placeholder="요청서 제목" required>
			<br>
		<h6 class="text-secondary">요청하는 상세내용을 작성해주세요.</h6>
		<textarea class="input_req form-control" name="custom_order_content" required></textarea>
			<br>
		<h6 class="text-secondary">희망 가격은 얼마인가요?</h6>
		<input class="input_req form-control" type="number" name="custom_order_price" placeholder="원" required>
			<br>
		<h6 class="text-secondary">희망 날짜는 언제인가요? </h6>
		<input class="input_req form-control" type="date" name="custom_order_hopedate" required>
			<br>
		<h6 class="text-secondary">원하는 디자인 등이 있다면 함께 보내주세요.</h6>
		<input class="input_req form-control-file" type="file" name="files" multiple>
			<br>
		<input class="input_req form-control btn btn-primary" type="submit" value="요청서 보내기">
	</form>
</div>
</article>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>