<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sping" uri="http://www.springframework.org/tags" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<div style="padding-top: 50px;">
<jsp:include page="../template/header.jsp"></jsp:include>
</div>

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>상품 상세</h1></div>

	
<div class="offset-md-3 col-md-6">
<h1>${param.seller_id }님의 ${list.goods_name} 상품입니다</h2>
</div>
	<table class="table table-hover">
  <thead>
    <tr>
      <th width="15%">내용</th>
      <th width="15%">가격</th>
      <th width="15%">재고</th>
      <th width="15%">할인가격</th>
      <th width="15%">할인시작일</th>
      <th width="15%">할인종료일</th>
      <th width="10%">판매 여부</th>
    </tr>
  </thead>
  <tbody>
    <tr class="table-light">
      <th scope="row">${list.goods_content}</th>
      <td>${list.goods_price}</td>
      <td>${list.goods_stock}</td>
      <td>${list.goods_discount_price}</td>
      <td>${list.goods_discount_start.substring(0,10)}</td>
       <td>${list.goods_discount_finish.substring(0,10)}</td>
        <td>${list.goods_status}</td>
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

<div class="row justify-content-center" style="padding: 30px;">
<h1>${list.goods_name} 상품의 옵션</h2><br>
</div>

<table class="table table-hover">
  <thead>
    <tr>
      <th width="20%">옵션</th>
      <th width="20%">내용</th>
      <th width="20%">가격</th>
      <th width="20%">재고</th>
      <th width="20%">판매여부</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list.goodsOptionList }">
    <tr class="table-light">
      <th scope="row">${list.goods_option_title}</th>
      <td>${list.goods_option_content}</td>
      <td>${list.goods_option_price}</td>
      <td>${list.goods_option_stock}</td>
      <td>${list.goods_option_status}</td>
    </tr>
	</c:forEach>
  </tbody>
</table>

<h1><a href="${pageContext.request.contextPath}/goods/review?goods_no=${list.goods_no}&goods_name=${list.goods_name}"><button type="button" class="btn btn-primary offset-md-4 col-md-4">리뷰목록</button></a></h1>
	<c:if test="${admin_grade == '총괄관리자' }">
			<a href="${pageContext.request.contextPath}/goods/delete?goods_no=${list.goods_no}"><button type="button" class="btn btn-primary offset-md-4 col-md-4">삭제</button></a>
	</c:if>

</div>
        </div>
    </div>
