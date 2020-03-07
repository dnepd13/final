<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	.articleBox {
		width: 60%;
		margin: 0 auto;
		padding-top: 5rem;
	}
	.dataEmpty {
		height: 300px;
	}
	
	.new {
		float: right;
	}
</style>

<article class="articleBox infoPage-area">
<table class="table table-hover listBox">
<c:choose>
	<c:when test="${ empty getListResp }">
		<tr class="dataEmpty">
			<td>
				<div class="row-empty-40"></div><div class="row-empty-40"></div>
				<div align="center" style="padding: 10px;">
					받은 견적서가 없습니다.
				</div><div class="row-empty-40"></div><div class="row-empty-40"></div><div class="row-empty-40"></div>
				<p align="right"><a href="${pageContext.request.contextPath }/member/customCate"><button class="btn_custom">요청서 보내기</button></a></p>
			</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="sellerResp" items="${getListResp }">
			<tr>
				<td>
					<p><span>${sellerResp.seller_id } 님이 보낸 견적서입니다.</span>
						<span class="new" style="color: red">
							<c:set var="check" value="${sellerResp.member_alarm_check }"/>
							<c:if test="${functions : contains(check, 'N') }">
								new
							</c:if>
						</span>
					</p>
					<p><a href="customInfoResp?seller_custom_order_no=${sellerResp.seller_custom_order_no }">
								${sellerResp.custom_order_title }</a>
					</p>
					<span>
						<fmt:parseDate value="${sellerResp.custom_order_date }" var="custom_order_date" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${custom_order_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
					</span>
					<c:set var="check" value="${sellerResp.custom_order_status }"/>
					<c:if test="${functions : contains(check, '진행중') }">
						<span aria-hidden="true"><button class="close" aria-label="Close" onclick="deleteReq(${memberCustom.member_custom_order_no })">&times;</button></span>
					</c:if>
				</td>
		</c:forEach>
	</c:otherwise>
</c:choose>
</table>

<!-- 내비게이터 -->
<div class="row justify-content-center">
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
</article>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>