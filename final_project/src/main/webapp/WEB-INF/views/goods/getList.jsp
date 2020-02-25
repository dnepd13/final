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
	
	$(".goods_box").mouseover(function(){
		$(this).addClass("rounded border border-light shadow p-3 mb-5 bg-white");
	});
	
	$(".goods_box").mouseout(function(){
		$(this).removeClass("rounded border border-light shadow p-3 mb-5 bg-white");
	});
	
});
</script>
</head>

<style>
.goods_box{
	cursor: pointer;
	padding: 15px;
	margin: 52px 0px;
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
	font-size: 1.5rem;
}

.goods_price{
	font-size: 1rem;
	padding: 5px;
}

.goods_content{
	font-size: 1rem;
	padding: 5px;
}
</style>

<!-- Best -->
<!-- <div class="best_area"> -->
<!--   <h2>인기 상품</h2> -->
<!--   <div class="container"> -->
<!--   	<div class="row justify-content-center"> -->
<!--   		<div class="col-md-2"> -->
<!--   			ㅇ -->
<!--   		</div> -->
<!--   		<div class="col-md-2"> -->
<!--   			ㅇ -->
<!--   		</div> -->
<!--   		<div class="col-md-2"> -->
<!--   			ㅇ -->
<!--   		</div> -->
<!--   		<div class="col-md-2"> -->
<!--   			ㅇ -->
<!--   		</div> -->
<!--   		<div class="col-md-2"> -->
<!--   			ㅇ -->
<!--   		</div> -->
<!--   	</div> -->
<!--   </div> -->
<!-- </div> -->

<!-- <!-- 신규 --> -->
<!-- <div class="new_area"> -->
<!--   <h2>신규 상품</h2> -->
<!--   <div class="container"> -->
<!--   	<div class="row justify-content-center"> -->
<!--   		<div class="col-md-2"> -->
<!--   			ㅇ -->
<!--   		</div> -->
<!--   		<div class="col-md-2"> -->
<!--   			ㅇ -->
<!--   		</div> -->
<!--   		<div class="col-md-2"> -->
<!--   			ㅇ -->
<!--   		</div> -->
<!--   		<div class="col-md-2"> -->
<!--   			ㅇ -->
<!--   		</div> -->
<!--   		<div class="col-md-2"> -->
<!--   			ㅇ -->
<!--   		</div> -->
<!--   	</div> -->
<!--   </div> -->
<!-- </div> -->

<!--   <select name="align"> -->
<!--   	<option>정렬</option> -->
<!--   	<option value="price_asc">높은 가격순</option> -->
<!--   	<option value="price_desc">낮은 가격순</option> -->
<!--   </select> -->
<hr>
<div class="best_area">
  <p class="h2 text-center">인기 상품 목록</p>
  <hr>
  <div class="container">
  	<div class="row">
  	<c:forEach var="goodsFileVO" items="${listBest}">
  		<div class="col-lg-4 goods_box">
  			<a class="goods_img" href="goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
  			</a>
  		<p class="goods_name h4">${goodsFileVO.goodsDto.goods_name} <span class="badge badge-danger">New</span></p>
  		<p class="goods_price h5">
  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber> 원</p>
  		<p class="goods_content h5 text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
  		</div>
	</c:forEach>
  	</div>
  </div>
</div>



<hr>
<div class="new_area">
  <p class="h2 text-center">신규 상품 목록</p>
  <hr>
  <div class="container">
  	<div class="row">
  	<c:forEach var="goodsFileVO" items="${listNew}">
  		<div class="col-lg-4 goods_box">
  			<a class="goods_img" href="goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
  			</a>
  		<p class="goods_name h4">${goodsFileVO.goodsDto.goods_name} <span class="badge badge-danger">New</span></p>
  		<p class="goods_price h5">
  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber> 원</p>
  		<p class="goods_content h5 text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
  		</div>
	</c:forEach>
  	</div>
  </div>
</div>


<!-- 전체  -->
<hr>
<div class="all_area">
  <p class="h2 text-center">전체 목록</p>
  <hr>
  <div class="container">
  	<div class="row">
  	<c:forEach var="goodsFileVO" items="${list}">
  		<div class="col-lg-4 goods_box">
  			<a class="goods_img" href="goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
  			</a>
  		<p class="goods_name h4">${goodsFileVO.goodsDto.goods_name} <span class="badge badge-danger">Hot</span></p>
  		<p class="goods_price h5">
  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber> 원</p>
  		<p class="goods_content h5 text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
  		</div>
	</c:forEach>
  	</div>
  </div>
</div>









