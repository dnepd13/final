<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<h1>차단된 회원 목록</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">아이디</th>
      <th width="10%">그룹</th>
      <th width="40%">차단사유</th>
      <th width = "20%">차단날짜</th>
      <th width = "20%">차단해제</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list}">
    <tr class="table-light"">
      <th scope="row">${list.block_id}</th>
      <td>${list.block_group}</td>
      <td>${list.block_content}</td>
      <td>${list.block_date}</td>
      <td>
	      <form action="blocklist" method="post">
	      	<input type="hidden" name="block_no" value="${list.block_no }">
	      	<input type="submit" value="차단해제">
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
     			 <a class="page-link" href="${pageContext.request.contextPath}/blocklist?pno1=${paging.startBlock-1}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/blocklist?pno1=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/blocklist?pno1=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>
</div>