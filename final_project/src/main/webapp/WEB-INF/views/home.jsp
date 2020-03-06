<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>

<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script>
$(function(){
	$(".goods_box").click(function(){
		var url = $(this).children(".goods_img").attr("href");
		$(location).attr('href', url);
	});
	
// 	$(".goods_box").mouseover(function(){
// 		$(this).addClass("rounded border border-light shadow p-3 mb-5 bg-white");
// 	});
	
// 	$(".goods_box").mouseout(function(){
// 		$(this).removeClass("rounded border border-light shadow p-3 mb-5 bg-white");
// 	});
	
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
	font-size: 1rem;
	font-weight: bold;
}

.goods_price{
	font-size: 1rem;
	padding: 5px;
}

.goods_content{
	font-size: 1rem;
	padding: 5px;
}

.best_area {
	margin: 50px 0px;
}

.new_area {
	margin: 50px 0px;
}

.all_area {
	margin: 50px 0px;
}

</style>
<!-- 바뀐 session의 member_no에서 memeber_id를 구해서 확인  -->

<div class="best_area">
  <div class="container">
  	<div class="row">
	 <div class="col-12">
		 <h1 class="text-center">Best</h1>
	 </div>
  	<c:forEach var="goodsFileVO" items="${listBest}">
  		<div class="col-sm-4 goods_box">
  			<a class="goods_img" href="goods/goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
  				<img class="" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
  			</a>
	  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}</p>
	  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
	  		<p class="goods_price">
	  			<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber>
	  		</p>
  		</div>
	</c:forEach>
  	</div>
  </div>
</div>

<div class="new_area">
  <div class="container">
  	<div class="row">
  	<div class="col-12">
		 <h1 class="text-center">New</h1>
	 </div>
  	<c:forEach var="goodsFileVO" items="${listNew}">
  		<div class="col-lg-4 goods_box">
  			<a class="goods_img" href="goods/goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
  			</a>
  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}</p>
  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
  		<p class="goods_price">
  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber></p>
  		</div>
	</c:forEach>
  	</div>
  </div>
</div>

<!-- 전체  -->
<div class="all_area">
  <div class="container">
  	<div class="row">
  	<div class="col-12">
		 <h1 class="text-center">All</h1>
	 </div>
  	<c:forEach var="goodsFileVO" items="${list}">
  		<div class="col-lg-4 goods_box">
  			<a class="goods_img" href="goods/goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
  			</a>
  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}</p>
  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
  		<p class="goods_price">
  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber></p>
  		</div>
	</c:forEach>
  	</div>
  </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>