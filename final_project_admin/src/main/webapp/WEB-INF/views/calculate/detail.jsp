<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   
<h1>${param.seller_id } 님의 ${param.year }년 ${param.month }월 상세 정산 보기</h1>

<h1>판매자 이름 : ${sellername} / 판매자 이메일 : ${email } / 판매자 연락처 : ${phone } </h1>
<h1>상호명 : ${storename } / 회사 연락처 : ${storephone } </h1>
<h1>은행명 : ${bankname } / 계좌번호 : ${account } / 계좌명 : ${accountname }</h1>

<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">결제번호</th>
      <th width="15%">결제상태</th>
      <th width="15%">결제날짜</th>
      <th width="15%">상품</th>
      <th width="15%">판매 갯수</th>
      <th width="15%">상품 가격</th>
      <th width="15%">구매자</th> 
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list }">
    <tr class="table-light"">
      <th scope="row" >${list.partner_order_id }</th>
      <th>${list.ordering_status}</th>
      <td >${list.process_time }</td>
      <td>${list.goods_name }</td>
      <td>${list.cart_info_goods_quantity }</td>
      <td>${list.cart_info_goods_price }</td>
      <td>${list.member_id }</td>
    </tr>
	</c:forEach>
  </tbody>
</table>

<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<c:choose>
				<c:when test="${param.seller_id != null }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/calculate/detail?pno1=${paging.startBlock-1}&seller_id=${param.seller_id}&year=${param.year}&month=${param.month}">&laquo;</a>
		   			 </li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/calculate/detail?pno1=${paging.startBlock-1}&year=${param.year}&month=${param.month}">&laquo;</a>
		   			 </li>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:forEach begin="${paging.startBlock }" end="${paging.finishBlock }" var="p">
			<c:choose>
				<c:when test="${p == paging.pno }">
					<li class="page-item active">
   					   <a class="page-link" >${p }</a>
   					 </li>
				</c:when>
				<c:otherwise>
					<c:choose>
					<c:when test="${param.seller_id != null }">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/calculate/detail?pno1=${p}&seller_id=${param.seller_id}&year=${param.year}&month=${param.month}">${p }</a>
    					</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/calculate/detail?pno1=${p}&year=${param.year}&month=${param.month}">${p }</a>
			    		</li>
					</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<c:when test="${param.seller_id != null }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/calculate/detail?pno1=${paging.finishBlock+1}&seller_id=${param.seller_id}&year=${param.year}&month=${param.month}">&raquo;</a>
				</li>
			</c:when>
			<c:otherwise>
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/calculate/detail?pno1=${paging.finishBlock+1}&year=${param.year}&month=${param.month}">&raquo;</a>
    		</li>
			</c:otherwise>
		</c:if>
	</ul>
</div>