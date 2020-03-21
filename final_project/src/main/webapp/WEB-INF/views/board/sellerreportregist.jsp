<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 판매자 신고 등록기능 -->
<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<style>
.ordering_area {
	margin: 30px 0px;
}
.cart_table {
	border-top: 2px solid #171717;
	border-bottom: 1px solid #171717;
}
.col-lg-8 {
	margin: 25px 0px;
}
.cart_table_title {
	border-bottom: 1px solid #171717;
}
.items_area {
	border-bottom: 1px solid #171717;
}
.cart_area {
	margin: 15px 0px;
}
.section1{
	margin: 0 auto;
	width: 1500px;
}
h4{
	color:red;
}
</style>

<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
			<h3>신고 작성하기</h3>
		</div>
		<div>
			<h4>허위 신고로 적발될 경우 불이익을 받을 수 있습니다.</h4>
		</div>

<form action="sellerreportregist" method="post">
	<div style="width:1000px;">
<table>
	<tr>
		<th>
		<input type="text" name="admin_qna_title" placeholder="제목을 입력하세요 ex)판매자 xxx를 신고합니다" maxlength="68" required style="width:1000px;">
		</th>

	</tr>
	<tr>
		<td >	
		<textarea name="admin_qna_content" rows="15" cols="140" style="resize:none;">내용을 입력하세요</textarea>
		</td>
	</tr>
</table>
</div>
	<div class="btn-group-vertical" style="float:right;">
		<button class="btn btn-secondary" style="float:right;">등록</button>
	</div>

</form>
</div>
</div>
</section>

<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>






