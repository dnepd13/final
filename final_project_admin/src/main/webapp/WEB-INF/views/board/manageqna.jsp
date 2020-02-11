<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    
<h1>관리문의게시판</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>
<div class="btn-group-vertical">
	  <a href="${pageContext.request.contextPath}/board/write"><button type="button" class="btn btn-primary">글쓰기</button></a>
</div>
<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">말머리</th>
      <th width="40%">제목</th>
      <th width="15%">작성자</th>
      <th width="15%">작성자 구분</th>
      <th width="20%">작성일자</th>
    </tr>
  </thead>
  <tbody>
  	<c:forEach var="list" items="${list }">
    <tr>
      <th class="table-light">${list.admin_qna_head }</th>
      <td>
      <c:choose>
      <c:when test="${list.super_no > 0}">
     	 	<a href="${pageContext.request.contextPath}/board/detailqna?admin_qna_no=${list.admin_qna_no}">---->${list.admin_qna_title }</a>
      </c:when>
     	<c:otherwise>
     		<a href="${pageContext.request.contextPath}/board/detailqna?admin_qna_no=${list.admin_qna_no}">${list.admin_qna_title }</a>
     	</c:otherwise>
      </c:choose>
      </td>
      <td>${list.admin_qna_writer }</td>
      <td>${list.admin_qna_usertype }</td>
      <td>${list.admin_qna_date }</td>
    </tr>
  	</c:forEach>
  </tbody>
</table>

<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/board/manageqna?pno1=${paging.startBlock-1}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/board/manageqna?pno1=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/board/manageqna?pno1=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>
</div>