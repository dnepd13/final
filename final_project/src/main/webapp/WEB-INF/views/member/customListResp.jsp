<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>

<h3>구매자가 받은 견적서. member customListResp.jsp</h3>

<a href="${pageContext.request.contextPath }">home</a> &#124; 
<a href="customListReq">보낸 요청서</a>
<h4>확인 안 한 견적서 몇 개냐: <span>${customAlarm } 개</span></h4>	

<c:forEach var="sellerResp" items="${getListResp }">
<div>
	보낸사람: ${sellerResp.seller_id } <br>
	제목: <a href="customInfoResp?seller_custom_order_no=${sellerResp.seller_custom_order_no }">
						${sellerResp.custom_order_title }
			</a> 
			<span style="color: red">
				<c:set var="check" value="${sellerResp.member_alarm_check }"/>
				<c:if test="${functions : contains(check, 'N') }"> new </c:if>
			</span>
			<br>	
	작성일: ${sellerResp.custom_order_date } <br>
	<hr>
</div>
</c:forEach>

<!-- 내비게이터 -->
<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/customListResp?pageNo=${paging.startBlock-1}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/member/customListResp?pageNo=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/customListResp?pageNo=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>	
</div>

