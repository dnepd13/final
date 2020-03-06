<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   
<style>
	.justify-content-center{
		padding:30px;
	}	
</style>

<aside>
<div>
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article>

<div class="container-fluid">
        <div class="row">
            <div class="offset-md-1 col-md-10">
            <div class="row justify-content-center">
<h1>${param.seller_id } 님의 ${param.year }년 ${param.month }월 상세 정산 보기</h1>
            </div>
<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">이름</th>
      <th width="10%">이메일</th>
      <th width="10%">연락처</th>
      <th width="15%">상호명</th>
      <th width="15%">회사연락처</th>
      <th width="10%">은행명</th>
      <th width="20%">계좌번호</th>
      <th width="10%">계좌명</th>
    </tr>
  </thead>
  <tbody>
    <tr class="table-light">
      <th scope="row">${sellername}</th>
      <td>${email }</td>
      <td>${phone }</td>
      <td>${storename } </td>
      <td>${storephone }</td>
      <td>${bankname }</td>
      <td>${account } </td>
      <td>${accountname } </td>
    </tr>
  </tbody>
</table>

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

<div class="row justify-content-center">
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

   </div>
        </div>
    </div>
</article></section>