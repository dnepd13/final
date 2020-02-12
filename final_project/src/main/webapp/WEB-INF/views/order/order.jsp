<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h2>선택한 상품 목록</h2>
<c:forEach items="${cartVOList}" var="cartVO">
<hr>
	상품이름 : ${cartVO.goodsDto.goods_name}<br>
	상품가격 : <fmt:formatNumber pattern="###,###,###" type="number">${cartVO.goodsDto.goods_price}</fmt:formatNumber> 원<br>
	옵션 	: <br>
	<c:forEach items="${cartVO.option_list}" var="goodsOptionDto">
		- ${goodsOptionDto.goods_option_title } : 
		${goodsOptionDto.goods_option_content}  
		(<fmt:formatNumber pattern="###,###,###" type="number"> ${goodsOptionDto.goods_option_price}</fmt:formatNumber>원)
		<br>
	</c:forEach>
	가격 : <fmt:formatNumber pattern="###,###,###" type="number">${cartVO.price}</fmt:formatNumber> 원<br>	
	수량 : ${cartVO.quantity} 개 <br>
	총 가격 : <fmt:formatNumber pattern="###,###,###" type="number">${cartVO.price*cartVO.quantity}</fmt:formatNumber> 원
</c:forEach>
<hr>