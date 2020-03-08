<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	.articleBox {
		width: 1000px;
		margin-left: 300px;
		height: 500px;
		padding-top: 5rem;
	}
	@media screen and (min-width:1360px){
		.articleBox {
			width: 60%;
			margin: 0 auto;
		}
	}
	
	.detailPayBox {
		border-collapse: collapse;
	}
</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script>
	function payConfirm(){
		if(confirm("결제를 취소하시겠습니까? 취소하실 정보를 다시 한 번 확인해주세요.")){
			return true;
		}
		else{
			return false;
		}
	}
</script>

<article class="articleBox">
	<table class="table detailPayBox" border="1">
		<tr>
			<th>주문번호</th>
			<td>${payDetails.partner_order_id }</td>
		</tr>
		<tr>
			<th>상품명</th>
			<td>${payDetails.item_name }</td>
		</tr>
		<tr>
			<th>배송지</th>
			<td><h6>${payDetails.delivery_name }</h6><hr>
					<h6>(${payDetails.cart_info_addr_post })</h6>
					<h6>${payDetails.cart_info_addr_basic } &mid; ${payDetails.cart_info_addr_extra }</h6>
			</td>
		</tr>
		<tr>
			<th rowspan="3">결제금액</th>
			<td>${payDetails.total_amount } 원 ( VAT ${payDetails.vat_amount } 원)</td>
		</tr>
		<tr>
			<td>사용 포인트 ${payDetails.used_point } point</td>
		</tr>
		<tr>
			<td>배송비 ${payDetails.total_delivery_price } 원</td>
		</tr>
		<tr>
			<td>결제상태</td>
			<td>${payDetails.cart_info_status } 
					<fmt:parseDate value="${payDetails.process_time }" var="process_time" pattern="yyyy-MM-dd HH:mm:ss"/>
					(<fmt:formatDate value="${process_time }" pattern="yyyy/MM/dd HH:mm:ss"/>)
					<c:if test="${payDetails.cart_info_status == '결제완료'}">
					<a href="${pageContext.request.contextPath }/pay/kakao/customPayRevoke?ordering_no=${payDetails.ordering_no}">
						<button class="btn btn-warning payCancel" style="float:right;" onclick="payConfirm();">
							결제취소</button>
					</a>
					</c:if>
			</td>
		</tr>
	</table>

<p style="text-align: right;"><a href="${pageContext.request.contextPath }/member/cartList">목록으로</a></p>
</article>

<div class="row-empty-40"></div>
<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>