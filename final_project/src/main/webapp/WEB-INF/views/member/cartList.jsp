<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<style>
	* {box-sizing: border-box;}
	table {border-collapse: collapse;}
</style>

<h4>회원 주문내역페이지 member/orderingList.jsp</h4>

<div>
	<table  border="1">
		<c:forEach var="cartInfo" items="${getCartInfo }">
		<tr>
			<th>주문번호</th>
			<th>주문상품</th>
			<th>결제금액<br>(배송비)</th>
			<th>결제상태</th>
			<th>배송상태</th>
		</tr>
		<tr>
			<td>${cartInfo.partner_order_id }</td>
			<td><a href="${pageContext.request.contextPath }/member/cartDetails?cart_info_no=${cartInfo.cart_info_no}" >.....외 ${cartInfo.total_quantity } 건</a></td>
			<td>${cartInfo.total_price }<br>(${cartInfo.total_delivery_price })</td>
			<td>${cartInfo.cart_info_status }</td>
			<td>${cartInfo.cart_info_addr_status }</td>
		</tr>
		</c:forEach>
	</table>	
</div>


<!-- 내비게이터 -->
<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/orderingList?pageNo=${paging.startBlock-1}">&laquo;</a>
   			 </li>
		</c:if>
		<c:forEach begin="${paging.startBlock }" end="${paging.finishBlock }" var="p">
			<c:choose>
				<c:when test="${p == paging.pno }">
					<li class="page-item active">
   					   <a class="page-link" >${p }</a>
   					 </li>
				</c:when>
				<c:when test="${p != paging.pno }">
					<li class="page-item active">
      					<a class="page-link" href="${pageContext.request.contextPath}/member/orderingList?pageNo=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/orderingList?pageNo=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>	
</div>
