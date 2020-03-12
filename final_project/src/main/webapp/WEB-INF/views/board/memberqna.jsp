<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
			<h3>문의게시판</h3>
		</div>
		<div class="btn-group-vertical" style="float:right;">
			<a href="${pageContext.request.contextPath}/board/qnaregist">
				<button type="button" class="btn btn-primary">글쓰기</button>
			</a>
		</div>
		<table class="table table-borderless cart_table">
			<tr class="cart_table_title">
			
				<th scope="col" class="align-middle text-center" style="width: 800px">제목</th>
				<th scope="col" class="align-middle text-center" style="width: 150px">작성자</th>
				<th scope="col" class="align-middle text-center" style="width: 150px">구분</th>
				<th scope="col" class="align-middle text-center" style="width: 300px">작성시간</th>
			</tr>
			<c:forEach var="getListQna" items="${getListQna}">
			<tr class="items_area" align="center">
				<td align="left" style="padding-left: 20px;">
				<c:choose>
					<c:when test="${getListQna.super_no > 0}">
						<a href="${pageContext.request.contextPath}/board/detailmqna?admin_qna_no=${getListQna.admin_qna_no}">---->${getListQna.admin_qna_title }</a>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/board/detailmqna?admin_qna_no=${getListQna.admin_qna_no}">${getListQna.admin_qna_title }</a>	
					</c:otherwise>	
				</c:choose>
				</td>
				<td>${getListQna.admin_qna_writer}</td>
				<td>${getListQna.admin_qna_usertype}</td>
				<td>
					<fmt:parseDate value="${getListQna.admin_qna_date}" var="admin_qna_date" pattern="yyyy-MM-dd HH:mm:ss"/>
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
				<a class="page-item" href="${pageContext.request.contextPath}/board/memberqna?pno1=${paging1.startBlock-1}">&laquo;</a>

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
						<a class="page-link" href="${pageContext.request.contextPath}/board/memberqna?pno1=${p}">${p}</a>
					</li>

				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging1.finishBlock < paging1.pagecount}">
			<li class="page-item">
				<a class="page-link" href="${pageContext.request.contextPath}/board/memberqna?pno=${paging1.finishBlock+1}">&raquo;</a>
			</li>
		</c:if>
	</ul>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>