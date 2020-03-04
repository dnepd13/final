<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	.articleBox {
		width: 60%;
		height: 500px;
		padding-top: 5rem;
		margin: 0 auto;
	}
	
	.detailPayBox {
		border-collapse: collapse;
	}
</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script>
</script>

결제 상세정보 cartDetailPay.jsp

<article class="articleBox">
	<table class="table detailPayBox" border="1">
		<tr>
			<th>주문번호</th>
			<td>cart_info.partner_order_id</td>
		</tr>
		<tr>
			<th>상품명</th>
			<td>ordering.item_name</td>
		</tr>
		<tr>
			<th>배송지</th>
			<td><h6>cart_info.delivary_name</h6><hr>
					<h6>(cart_info.cart_info_addr_post)</h6>
					<h6>cart_info.cart_info_addr_basic &mid; cart_info.cart_info_addr_extra</h6>
			</td>
		</tr>
		<tr>
			<th rowspan="3">결제금액</th>
			<td>ordering.total_amount(ordering.vat_amount)</td>
		</tr>
		<tr>
			<td>사용 포인트 cart_info.used_point</td>
		</tr>
		<tr>
			<td>배송비 cart_info.total_delivary_price</td>
		</tr>
		<tr>
			<td>결제상태</td>
			<td>cart_info.cart_info_status (ordering.process_time)
				<a href="${pageContext.request.contextPath }/pay/kakao/revokeCustom">
					<button class="btn btn-warning payCancel" style="float:right;">결제취소</button>
				</a>
			</td>
		</tr>
	</table>

<p style="text-align: right;"><a href="${pageContext.request.contextPath }/member/cartList">목록으로</a></p>
</article>

<div class="row-empty-40"></div>
<div class="row-empty-40"></div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>