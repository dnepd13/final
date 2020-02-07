<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>전체 조회 페이지(list)</h1>
<c:forEach var="goodsDto" items="${list}">
	${goodsDto.goods_no} /
	${goodsDto.seller_no} /
	${goodsDto.goods_name} /
	${goodsDto.goods_price} /
	${goodsDto.goods_discount_start} /
	${goodsDto.goods_discount_finish} /
	${goodsDto.goods_discount_price} /
	${goodsDto.goods_stock} /
	${goodsDto.goods_status} /
	${goodsDto.goods_content} /
	${goodsDto.category_no}
	<a href="goodsInfo?goods_no=${goodsDto.goods_no}">상세보기</a>
	<br><hr><br>
</c:forEach>