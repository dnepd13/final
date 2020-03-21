<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!-- 판매자 문의 info  -->

<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/> 

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
.ordering_area {
	margin: 30px 0px;

}
.cart_table {
	border-top: 2px solid #171717;
	border-bottom: 1px solid #171717;
}
.col-lg-8 {
	margin: 25px 0px;
}
.cart_table_title {
	border-bottom: 1px solid #171717;
}
.items_area {
	border-bottom: 1px solid #171717;
}
.cart_area {
	margin: 15px 0px;
}
.section1{
	margin: 0 auto;
	width: 1500px;
}
</style>
<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
			<h3>문의게시판</h3>
		</div>
		<div class="btn-group-vertical" style="float:right;">
			<a href="${pageContext.request.contextPath}/board/sellerqnaregist">
				<button type="button" class="btn btn-secondary">글쓰기</button>
			</a>
		</div>
<table class="table table-borderless cart_table">
			<tr class="cart_table_title">
			
				<th scope="col" class="align-middle text-center" style="width: 800px">제목</th>
				<th scope="col" class="align-middle text-center" style="width: 150px">작성자</th>
				<th scope="col" class="align-middle text-center" style="width: 150px">구분</th>
				<th scope="col" class="align-middle text-center" style="width: 300px">작성시간</th>
			</tr>
			<c:forEach var="getListSellerQna" items="${getListSellerQna}">
			<tr class="items_area" align="center">
				<td align="left" style="padding-left: 20px;">
				<c:choose>
					<c:when test="${getListSellerQna.super_no > 0}">
						<a href="${pageContext.request.contextPath}/board/sellerdetailmqna?admin_qna_no=${getListSellerQna.admin_qna_no}">---->${getListSellerQna.admin_qna_title }</a>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/board/sellerdetailmqna?admin_qna_no=${getListSellerQna.admin_qna_no}">${getListSellerQna.admin_qna_title }</a>	
					</c:otherwise>	
				</c:choose>
				</td>
				<td>${getListSellerQna.admin_qna_writer}</td>
				<td>${getListSellerQna.admin_qna_usertype}</td>
				<td>
					<fmt:parseDate value="${getListSellerQna.admin_qna_date}" var="admin_qna_date" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${admin_qna_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</table>
	</div>
</div>
</section>
<ul class="pagination row justify-content-center">
		<c:if test="${paging1.startBlock > 1 }">
			<li class="page-item">
				<a class="page-item" href="${pageContext.request.contextPath}/board/sellerqna?pno2=${paging1.startBlock-1}">&laquo;</a>

			</li>
		</c:if>

<c:forEach begin="${paging1.startBlock }" end="${paging1.finishBlock }" var="p">
			<c:choose>
				<c:when test="${p == paging1.pno }">
					<li class="page-item active">
						<a class="page-link">${p }</a>
					</li>
				</c:when>
				<c:when test="${p != paging1.pno }">
					<li class="page-item active">
						<a class="page-link" href="${pageContext.request.contextPath}/board/sellerqna?pno2=${p}">${p}</a>
					</li>

				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging1.finishBlock < paging1.pagecount}">
			<li class="page-item">
				<a class="page-link" href="${pageContext.request.contextPath}/board/sellerqna?pno=${paging1.finishBlock+1}">&raquo;</a>
			</li>
		</c:if>
	</ul>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>
<!-- <div align="center" class="btn-group-vertical"> -->



<!-- <h2>판매자 문의게시판</h2> -->
<%-- <h2><a href="${pageContext.request.contextPath}/">홈으로</a></h2> --%>

<!-- <div class="btn-group-vertical"> -->
<%-- 	<a href="${pageContext.request.contextPath}/board/sellerqnaregist"> --%>
<!-- 		<button type="button" class="btn btn-primary">글쓰기</button> -->
<!-- 	</a> -->
<!-- </div> -->
<!-- <table class="table table-hover"> -->
<!-- 	<thead> -->
<!-- 		<tr> -->
<!-- 			<th width="40%">제목</th> -->
<!-- 			<th width="15%">작성자</th> -->
<!-- 			<th width="15%">작성자 구분</th> -->
<!-- 			<th width="20%">작성일</th> -->
<!-- 		</tr> -->
<!-- 	</thead> -->
	
<!-- 	<tbody> -->
<%-- 		<c:forEach var="getListSellerQna" items="${getListSellerQna}"> --%>
<!-- 		<tr> -->
<!-- 			<td> -->
<%-- 			<c:choose> --%>
<%-- 			<c:when test="${getListSellerQna.super_no > 0}"> --%>
<%-- 				<a href="${pageContext.request.contextPath}/board/sellerdetailmqna?admin_qna_no=${getListSellerQna.admin_qna_no}">---->${getListSellerQna.admin_qna_title }</a> --%>
<%-- 			</c:when> --%>
<%-- 				<c:otherwise> --%>
<%-- 					<a href="${pageContext.request.contextPath}/board/sellerdetailmqna?admin_qna_no=${getListSellerQna.admin_qna_no}">${getListSellerQna.admin_qna_title }</a>	 --%>
<%-- 				</c:otherwise>	 --%>
<%-- 			</c:choose> --%>
<!-- 			</td> -->
<%-- 		    <td>${getListSellerQna.admin_qna_writer}</td> --%>
<%-- 			<td>${getListSellerQna.admin_qna_usertype}</td> --%>
<%-- 			<td>${getListSellerQna.admin_qna_date}</td> --%>

<!-- 		</tr> -->
<%-- 		</c:forEach> --%>
<!-- 	</tbody> -->


<!-- </table> -->
<!-- 	<ul class="pagination1"> -->
<%-- 		<c:if test="${paging1.startBlock > 1 }"> --%>
<!-- 			<li class="page-item"> -->
<%-- 				<a class="page-item" href="${pageContext.request.contextPath}/board/sellerqna?pno2=${paging1.startBlock-1}">&laquo;</a> --%>

<!-- 			</li> -->
<%-- 		</c:if> --%>
<%-- 		<c:forEach begin="${paging1.startBlock }" end="${paging1.finishBlock }" var="p"> --%>
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${p == paging1.pno }"> --%>
<!-- 					<li class="page-item active"> -->
<%-- 						<a class="page-link">${p }</a> --%>
<!-- 					</li> -->
<%-- 				</c:when> --%>
<%-- 				<c:when test="${p != paging1.pno }"> --%>
<!-- 					<li class="page-item active"> -->
<%-- 						<a class="page-link" href="${pageContext.request.contextPath}/board/sellerqna?pno2=${p}">${p}</a> --%>
<!-- 					</li> -->

<%-- 				</c:when> --%>
<%-- 			</c:choose> --%>
<%-- 		</c:forEach> --%>
<%-- 		<c:if test="${paging1.finishBlock < paging1.pagecount}"> --%>
<!-- 			<li class="page-item"> -->
<%-- 				<a class="page-link" href="${pageContext.request.contextPath}/board/sellerqna?pno=${paging1.finishBlock+1}">&raquo;</a> --%>
<!-- 			</li> -->
<%-- 		</c:if> --%>
<!-- 	</ul> -->

<!-- </div>  -->