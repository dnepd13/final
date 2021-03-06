<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 

<style>
	* {box-sizing: border-box;}
	
	.articleBox {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
	}
	.cartList {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 960px;
	}
	.cart_main {
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;
	}
	.cart_mainBox1 {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large; 
	}		
	.cartContent {
		margin: 30px auto;
		width: 80%;
	}
	
	table {border-collapse: collapse;}
	.table_head {
		background-color: #F3F5F8;
	}

</style>

<article class="articleBox">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
	<div class="cartList">
		<div class="cart_main">
			<div class="cart_mainBox1">
				주문내역
			</div>
		</div>	
		<div class="cartContent">
			<table class="table table-hover" border="1">
				<thead align="center">
				    <tr class="table_head">
				      <th scope="col" width="10%">주문번호</th>
				      <th scope="col" width="45%">주문상품</th>
				      <th scope="col" width="10%">총 수량</th>
				      <th scope="col" width="15%">결제금액<br>(배송비)</th>
				      <th scope="col" width="10%">결제상태</th>
				    </tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${empty getCartInfo }">
						<tr>
							<td colspan="5" align="center"> 주문 내역이 없습니다. </td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="cartInfo" items="${getCartInfo }">
					    <tr align="center">
							<td scope="row">${cartInfo.partner_order_id }</td>
							<td align="left"><a href="${pageContext.request.contextPath }/member/cartDetailGoods?cart_info_no=${cartInfo.cart_info_no}" >${cartInfo.item_name }</a></td>
							<td>${cartInfo.total_quantity}</td>	
							<td>${cartInfo.total_price } 원<br>(${cartInfo.total_delivery_price } 원)</td>
							<td><a href="${pageContext.request.contextPath }/member/cartDetailPay?partner_order_id=${cartInfo.partner_order_id }">${cartInfo.cart_info_status }</a></td>
						</tr>
					    </c:forEach>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table> 
		</div>
			
			<!-- 내비게이터 -->
			<div class="row justify-content-center">
				<ul class="pagination">
					<c:if test="${paging.startBlock > 1 }">
						<li class="page-item">
			     			 <a class="page-link" href="${pageContext.request.contextPath}/member/cartList?pageNo=${paging.startBlock-1}">&laquo;</a>
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
			      					<a class="page-link" href="${pageContext.request.contextPath}/member/cartList?pageNo=${p}">${p }</a>
			   					 </li>
							</c:when>
						</c:choose>
					</c:forEach>
					<c:if test="${paging.finishBlock < paging.pagecount}">
						<li class="page-item">
			     			 <a class="page-link" href="${pageContext.request.contextPath}/member/cartList?pageNo=${paging.finishBlock+1}">&raquo;</a>
			    		</li>
					</c:if>
				</ul>	
			</div>

	</div>
</article>

<div class="row-empty-40"></div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>