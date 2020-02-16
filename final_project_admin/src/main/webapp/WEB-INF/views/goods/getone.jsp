<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<h1>상품 상세보기</h1>
	<c:if test="${admin_grade == '총괄관리자' }">
		<div class="btn-group-vertical">
			<a href="${pageContext.request.contextPath}/goods/delete?goods_no=${list.goods_no}"><button type="button" class="btn btn-primary">삭제</button></a>
		</div>
	</c:if>
<h2>${param.seller_id }님의 ${list.goods_name} 상품입니다</h2>

	<h1>${list.goods_content}</h1>
	<h1>${list.goods_price}</h1>
	<h1>${list.goods_stock}</h1>
	<h1>${list.goods_discount_price}</h1>
	<h1>${list.goods_discount_start}</h1>
	<h1>${list.goods_discount_finish}</h1>
	<h1>${list.goods_status}</h1>

<h1>옵션</h1>	
	<c:forEach var="list" items="${list.goodsOptionList }">
		<h4>${list.goods_option_title } : ${list.goods_option_content } 가격 : ${list.goods_option_price } 원 재고 : ${list.goods_option_stock } 판매여부 : ${list.goods_option_status }</h4>
	</c:forEach>

