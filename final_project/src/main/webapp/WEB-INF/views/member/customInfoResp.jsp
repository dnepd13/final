<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
 
 <style>
 	.articleBox {
 		width: 500px;
		margin: 0 auto;
	}
		
	.card-footer input[type=submit]{
		border: 0;
	}

</style>

<h3>member Custom Info Resp.jsp</h3>
<div class="row-empty-40"></div>

<article class="articleBox">

<div class="card mb-3">
	<div class="card-header">
		<h5>${getListInfoResp.custom_order_title }</h5>
		<h6 class="card-subtitle text-muted">
			<span>
				<c:choose>
			 		<c:when test="${not empty category }">
					 	카테고리: ${category.category_large } / ${category.category_middle } / ${category.category_small } <br> 
			 		</c:when>
			 		<c:otherwise>
			 			${getListInfoResp.seller_id } 님에게 받은 견적서
			 		</c:otherwise>
		 		</c:choose>
			</span>
			<span style="float:right;">${getListInfoResp.custom_order_date}</span><br>
			<span style="float:right;">${getListInfoResp.custom_order_status }</span>
		</h6>
	</div>
	<div class="card-body cart-text">
		<p>${getListInfoResp.custom_order_content }</p>
		<hr>
	</div>
	<c:if test="${ not empty filesVO }">
		<div align="center">
			<c:forEach var="filesVO" items="${filesVO }">
				<img src="http://localhost:8080/ordering/seller/download?files_no=${filesVO.files_no }" width=50%; height=auto;>
			</c:forEach>
		</div>
		<hr>
	</c:if>
	<ul class="list-group list-group-flush">
		<li class="list-group-item card-text">
			<h6 class="card-subtitle text-muted">견적가격&Tab;</h6>
				<fmt:formatNumber pattern="###,###,###" type="number">
					${getListInfoResp.custom_order_price }
				</fmt:formatNumber> 원
			</li>
		<li class="list-group-item card-text">
			<h6 class="card-subtitle text-muted">가능날짜&Tab;</h6>
			${getListInfoResp.custom_order_hopedate }
			</li>
	</ul>
	<div class="card-footer text-muted content_last" align="right">
		<form action="${pageContext.request.contextPath }/order/custom" method="POST">
			<input type="hidden" name="seller_custom_order_no" value="${getListInfoResp.seller_custom_order_no }">
			<input type="submit" value="수락 및 결제하기">
			&verbar; 
<%-- 		<a href="${pageContext.request.contextPath }/order/custom" style="font-weight: bold;">수락 및 결제하기</a> &verbar;  --%>
		<a href="${pageContext.request.contextPath }/member/customListReq">목록으로</a>		
		</form>
	</div>
</div>
</article>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>