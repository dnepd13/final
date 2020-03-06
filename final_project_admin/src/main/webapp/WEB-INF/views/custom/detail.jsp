<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    

<aside>
<div>
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article>

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
	
<div class="offset-md-3 col-md-6">

<c:choose>
	<c:when test="${list.seller_id =! null }">
		<h1>${list.seller_id }님의 견적서입니다</h1>
	</c:when>
	<c:otherwise>
		<h1>${list.member_id }님의 요청서입니다</h1>
	</c:otherwise>
</c:choose>
</div>
	<table class="table table-hover">
  <thead>
    <tr>
      <th width="30%">항목</th>
      <th width="70%">내용</th>
    </tr>
  </thead>
  <tbody>
  	<tr class="table-light">
      <c:choose>
      	<c:when test="${list.category_large != null }">
      <th scope="row">카테고리</th>
	      <td>${list.category_large}-${list.category_middle}-${list.category_small}</td>
      	</c:when>
      </c:choose>
    </tr>
    <tr class="table-light">
      <th scope="row">제목</th>
      <td>${list.custom_order_title}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">내용</th>
      <td>${list.custom_order_content}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">가격</th>
      <td>${list.custom_order_price}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">작성날짜</th>
      <td>${list.custom_order_date}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">요구날짜</th>
      <td>${list.custom_order_hopedate}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">진행상황</th>
      <td>${list.custom_order_status}</td>
    </tr>
  </tbody>
</table>

<div class="row justify-content-center" style="padding: 50px;">
<h3>상품 사진</h3>
</div>
<div class="row justify-content-center" style="padding: 30px;" >
<c:forEach var="filesVO" items="${file }">
	<img src="http://localhost:8080/admin/goods/download?files_no=${filesVO.files_no }" width=150px; height=150px;>
</c:forEach>
</div>
</div></div></div></article></section>
<!-- <div class="row justify-content-center" style="padding: 50px;"> -->

<!-- <h3>상품 사진</h3> -->
<!-- </div> -->
<!-- <div class="row justify-content-center" style="padding: 30px;" > -->
<%-- <c:forEach var="filesVO" items="${file }"> --%>
<%-- 	<img src="http://localhost:8080/admin/goods/download?files_no=${filesVO.files_no }" width=150px; height=150px;> --%>
<%-- </c:forEach> --%>
<!-- </div> -->

