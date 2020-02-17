<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h3>구매자가 보낸 요청서. member customListReq.jsp</h3>

<a href="${pageContext.request.contextPath }">home</a> &#124; 
<a href="customListResp">받은 견적서</a>
<h4>확인 안 한 견적서 몇 개냐: <span>${customAlarm } 개</span></h4>	

<c:forEach var="memberCustom" items="${getListReq }">
<div>
	<a href="customInfoReq?member_custom_order_no=${memberCustom.member_custom_order_no }">
		제목: ${memberCustom.custom_order_title }
	</a> 
	<span><a href="#"> &timesb;</a></span>
	<br>
	작성일: ${memberCustom.custom_order_date }
	<hr>
</div>
</c:forEach>

<!-- 내비게이터 -->
<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/customListReq?pageNo=${paging.startBlock-1}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/member/customListReq?pageNo=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/customListReq?pageNo=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>	
</div>
