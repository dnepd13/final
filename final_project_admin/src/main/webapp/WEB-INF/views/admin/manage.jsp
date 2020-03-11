<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

<script>
$(function(){
	$(".adminPw").hide();
});
</script>

<style>
	.arti{
		overflow: hidden;
	}
</style>

<aside>
<div>
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article class="arti">

<div class="container-fluid" >
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>관리자 목록</h1></div>

<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">번호</th>
      <th width="15%">아이디</th>
      <th width="10%">이름</th>
      <th width="15%">이메일</th>
      <th width="10%">등급</th>
      <th width="10%">가입일</th>
      <th width="10%">마지막 접속일시</th>
      <th width = "10%">삭제</th>
      <th width="10%)">비밀번호 초기화</th>
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
      			<button class="btn btn-primary" >삭제</button>
      		</form>
      </td>
      <td>
      		<form action="reset" method="post">
      			<input type="hidden" name="admin_no" value="${list.admin_no }">
      			<input class="adminPw" type="password" name="admin_pw" value="123456789a">
      			<button class="btn btn-primary" >초기화</button>
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
</article></section>