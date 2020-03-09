<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<div align="center" class="btn-group-vertical">



<h2>판매자 신고 게시판</h2>
<h2><a href="${pageContext.request.contextPath}/">홈으로</a></h2>

<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/board/sellerreportregist">
		<button type="button" class="btn btn-primary">글쓰기</button>
	</a>
</div>
<table class="table table-hover">
	<thead>
		<tr>
			<th width="40%">제목</th>
			<th width="15%">작성자</th>
			<th width="15%">작성자 구분</th>
			<th width="20%">작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="getListSellerReport" items="${getListSellerReport}">
		<tr>
			<td>
			<c:choose>
			<c:when test="${getListSellerReport.super_no > 0}">
				<a href="${pageContext.request.contextPath}/board/sellerdetailreport?admin_qna_no=${getListSellerReport.admin_qna_no}">---->${getListSellerReport.admin_qna_title }</a>
			</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/board/sellerdetailreport?admin_qna_no=${getListSellerReport.admin_qna_no}">${getListSellerReport.admin_qna_title }</a>	
				</c:otherwise>	
			</c:choose>
			</td>

		    <td>${getListSellerReport.admin_qna_writer}</td>
			<td>${getListSellerReport.admin_qna_usertype}</td>
			<td>${getListSellerReport.admin_qna_date}</td>

		</tr>
		</c:forEach>
	</tbody>


</table>

	<ul class="pagination1">
		<c:if test="${paging1.startBlock > 1 }">
			<li class="page-item">
				<a class="page-item" href="${pageContext.request.contextPath}/board/sellerreport?pno2=${paging1.startBlock-1}">&laquo;</a>

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
						<a class="page-link" href="${pageContext.request.contextPath}/board/sellerreport?pno2=${p}">${p}</a>
					</li>

				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging1.finishBlock < paging.pagecount}">
			<li class="page-item">
				<a class="page-link" href="${pageContext.request.contextPath}/board/sellerreport?pno=${paging1.finishBlock+1}">&raquo;</a>
			</li>
		</c:if>
	</ul>

</div> 