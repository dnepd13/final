<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<h1>정산...</h1>


<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">이름</th>
      <th width="10%">아이디</th>
      <th width="10%">연락처</th>
       <th width="10%">상호명</th>
      <th width="10%">은행</th>
      <th width="10%">계좌번호</th>
      <th width="10%">계좌이름</th>
      <th width="10%">총 판매금액</th>
      <th width="10%">수수료율(%)</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${cal }">
    <tr class="table-light"">
      <th scope="row">${list.seller_name }</th>
      <td>${list.seller_id }</td>
      <td>${list.seller_phone }</td>
      <td>${list.seller_store_name }</td>
      <td >${list.seller_bank_code }</td>
      <td>${list.seller_bank_account }</td>
      <td>${list.seller_bank_username }</td>
      <td>${list.total }</td>
      <td>${list.rate }</td>
    </tr>
	</c:forEach>
  </tbody>
</table>

<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/calculate/total?pno1=${paging.startBlock-1}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/calculate/total?pno1=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/calculate/total?pno1=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>
</div>