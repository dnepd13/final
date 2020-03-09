<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header-sellerMain.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
 
 <style>
 	.articleBox {
 		width: 500px;
		margin: 0 auto;
	}

 </style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<article class="articleBox">

<div class="card mb-3">
	<div class="card-header">
		<h5>${getListInfoReq.custom_order_title }</h5>
		<h6 class="card-subtitle text-muted">
			<span>
				<c:choose>
			 		<c:when test="${not empty category }">
			 			${getListInfoReq.member_id } 님에게 받은
			 			" ${category.category_large } / ${category.category_middle } / ${category.category_small } "
			 			요청서					 	
			 		</c:when>
			 		<c:otherwise>
			 			${getListInfoReq.member_id } 님에게 받은 요청서
			 		</c:otherwise>
		 		</c:choose>
			</span>
			<span style="float:right;">
				<fmt:parseDate value="${getListInfoResp.custom_order_date}" var="custom_order_date" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${custom_order_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
			</span><br>
			<span style="float:right;">${getListInfoResp.custom_order_status }</span>
		</h6>
	</div>
	<div class="card-body cart-text">
		<p>${getListInfoReq.custom_order_content }</p>
		<hr>
	</div>
	<c:if test="${ not empty filesVO }">
		<div align="center">
			<c:forEach var="filesVO" items="${filesVO }">
				<img src="http://localhost:8080/ordering/member/download?files_no=${filesVO.files_no }" width=50%; height=auto;>
			</c:forEach>
		</div>
		<hr>
	</c:if>
	<ul class="list-group list-group-flush">
		<li class="list-group-item card-text">
			<h6 class="card-subtitle text-muted">희망가격&Tab;</h6>
				<fmt:formatNumber pattern="###,###,###" type="number">
					${getListInfoReq.custom_order_price }
				</fmt:formatNumber> 원
			</li>
		<li class="list-group-item card-text">
			<h6 class="card-subtitle text-muted">희망날짜&Tab;</h6>
			${getListInfoReq.custom_order_hopedate }
			</li>
	</ul>
	<div class="card-footer text-muted content_last" align="right">
		<a href="${pageContext.request.contextPath}/seller/customOrder?member_custom_order_no=${getListInfoReq.member_custom_order_no}&category_no=${category.category_no }" style="font-weight: bold;">견적서 보내기</a> &verbar; 
		<a href="${pageContext.request.contextPath }/seller/customListReq">목록으로</a>		
	</div>
</div>
</article>

    
<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>