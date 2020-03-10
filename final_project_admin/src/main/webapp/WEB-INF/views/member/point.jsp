<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">

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
<div class="container-fluid">
        <div class="row">
            <div class="offset-md-1 col-md-10">



<div class="row justify-content-center" style="padding: 50px;"><h1>${member_id } 회원님의 포인트 창 </h1></div>


<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">포인트 사용량</th>
      <th width="20%">포인트 상태</th>
      <th width="20%">포인트 날짜</th>
      <th width="20%">포인트 기간</th>
      <th width="20%">포인트 사용 내역</th>
      <th width="10%">삭제</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list }">
	    <tr>
	      <th scope="row">${list.member_point_change }</th>
	      <td>${list.member_point_status }</td>
	      <td>${list.member_point_date }</td>
	      <td>${list.member_point_limit.substring(0,10) }</td>
	      <td>${list.member_point_content }</td>
	      <td>
	      		<form action="" method="post">
	      		  <input type="hidden" name="member_point_no" value="${list.member_point_no }">
	      		  <input type="hidden" name="paging_member_no" value="${paging.member_no}">
			      <button type="submit" class="btn btn-primary btn-delete" >삭제</button>
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
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/point?pno1=${paging.startBlock-1}&member_no=${paging.member_no}&member_id=${member_id}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/member/point?pno1=${p}&member_no=${paging.member_no}&member_id=${member_id}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/point?pno1=${paging.finishBlock+1}&member_no=${paging.member_no}&member_id=${member_id}">&raquo;</a>
    		</li>
		</c:if>
	</ul>
</div>
</div>

<div class="offset-md-10 col-md-10">
<h1><a href="${pageContext.request.contextPath}/member/pointregist?member_no=${paging.member_no}">
<button type="button" class="btn btn-primary btn-delete" >포인트 등록</button>
</a></h1>
</div>
</div>
        </div>
    </div>
    </article></section>