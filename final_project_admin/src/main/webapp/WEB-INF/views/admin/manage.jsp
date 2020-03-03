<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    
<div style="padding-top: 50px;">
<jsp:include page="../template/header.jsp"></jsp:include>
</div>


<div class="container-fluid" >
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>관리자 목록</h1></div>

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
  <div class="row justify-content-center">
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
</div>
   </div>
        </div>
    </div>
