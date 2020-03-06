<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script>
$(function(){
	$(".goods_box").click(function(){
		var url = $(this).children(".goods_img").attr("href");
		$(location).attr('href', url);
	});
	
});
</script>
</head>

<style>
.goods_box{
	cursor: pointer;
	padding: 15px;
}

.goods_box > p {
	margin: 0px;
}

.goods_img {
	width: 100%;
	height: 230px;
}

.goods_img > img {
	width: 100%;
	height: 250px;
	margin: 10px auto;
}

.goods_name{
	font-size: 1.1rem;
	font-weight: bold;
}

.goods_price{
	font-size: 1rem;
}

.goods_content{
	font-size: 1rem;
}

.search_area {
	margin: 50px 0px;
}


</style>
<hr>
<div class="search_area">
  <p class="h2 text-center">검색 결과</p>
  <hr>
  <div class="container">
  	<div class="row">
  	<c:forEach var="goodsFileVO" items="${list}">
  		<div class="col-lg-3 goods_box">
  			<a class="goods_img" href="goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
  			</a>
  		<p class="goods_name h4">${goodsFileVO.goodsDto.goods_name}</p>
  		<p class="goods_content h5 text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
  		<p class="goods_price h5">
  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber></p>
  		</div>
	</c:forEach>
  	</div>
  </div>
</div>









