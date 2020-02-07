<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    
<h1>관리자 관리</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">번호</th>
      <th width="15%">아이디</th>
      <th width="15%">이름</th>
      <th width="15%">이메일</th>
      <th width="15%">등급</th>
      <th width="10%">가입일</th>
      <th width="10%">마지막 접속일시</th>
      <th width = "10%">삭제</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list }">
    <tr class="table-light"">
      <th scope="row">${list.admin_no }</th>
      <td>${list.admin_id }</td>
      <td>${list.admin_name }</td>
      <td>${list.admin_email }</td>
      <td>${list.admin_grade }</td>
      <td>${list.admin_join_date }</td>
      <td>${list.admin_last_login }</td>
      <td>
      		<form action="" method="post">
      			<input type="hidden" name="admin_no" value="${list.admin_no }">
      			<input type="submit" value="삭제">
      		</form>
      </td>
    </tr>
	</c:forEach>
  </tbody>
</table>
<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/admin/manage?pno1=${paging.startBlock-1}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/admin/manage?pno1=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/admin/manage?pno1=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>
</div>
