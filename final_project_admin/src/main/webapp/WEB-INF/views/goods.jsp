<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<h1>상품관리</h1>
<table class="table table-hover">
  <thead>
    <tr>
      <th width="15%">판매자</th>
      <th width="20%">카테고리</th>
      <th width="15%">상품이름</th>
      <th width="15%">가격</th>
      <th width="10%">제고</th>
      <th width="10%">판매상태</th>
      <th width="10%">삭제/상세보기</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list }">
    <tr class="table-light">
      <th scope="row">${list.goods_no}</th>
      <td>${list.goods_stock}</td>
      		<form action="" method="post">
      			<input type="hidden" name = "seller_no" value="${list.seller_no }">
      			<input type="submit" value="상세보기">
      		</form>
    </tr>
	</c:forEach>
  </tbody>
</table>