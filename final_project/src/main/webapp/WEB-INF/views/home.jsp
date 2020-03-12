<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>

<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/js/star/hakademy-star.min.js"></script>
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
	
	
	Hakademy.PointManager.factory(".star-wrap");
});
</script>
</head>

<style>
.goods_box{
	cursor: pointer;
	padding: 15px;
}

/* .goods_box > p { */
/* 	margin: 0px; */
/* } */

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
	margin: 5px 0px;
	font-size: 1.1rem;
	font-weight: bold;
}

.goods_price{
	margin-top: 7px;
	margin-bottom: 5px;
	font-size: 1.1rem;
	font-weight: bold;
}

.goods_content{
	margin: 5px 0px;
	font-size: 1rem;
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

.soldout {
	text-decoration: line-through;
}

.badge {
	margin-left: 10px;
}

</style>
<!-- 바뀐 session의 member_no에서 memeber_id를 구해서 확인  -->


<div class="best_area">
  <div class="container">
  	<div class="row">
	 <div class="col-12">
		 <h1 class="title">인기 상품</h1>
	 </div>
  	<c:forEach var="goodsFileVO" items="${listBest}" varStatus="status">
  	 	<c:choose>
  	 		<c:when test="${goodsFileVO.goodsDto.goods_stock>0}">
		  		<div class="col-sm-4 goods_box">
		  			<a class="goods_img" href="goods/goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
		  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
		  			</a>
			  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}<span class="badge badge-danger">Hot</span></p>
			  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
			  		<p class="goods_price">
			  			<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber>
			  		</p>
	  				<div class="star-wrap" data-limit="5" data-unitsize="20" data-point="${starListBest[status.index]}" data-image="http://www.sysout.co.kr/file/image/288" data-readonly></div>
		  		</div>
  	 		</c:when>
  	 		<c:otherwise>
  	 			<div class="col-sm-4 goods_box soldout">
		  			<a class="goods_img" href="goods/goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
		  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
		  			</a>
			  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}<span class="badge badge-secondary">품절</span></p>
			  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
			  		<p class="goods_price">
			  			<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber>
			  		</p>
			  		<div class="star-wrap" data-limit="5" data-unitsize="20" data-point="${starListBest[status.index]}" data-image="http://www.sysout.co.kr/file/image/288" data-readonly></div>
		  		</div>
  	 		</c:otherwise>
  		</c:choose>
	</c:forEach>
  	</div>
  </div>
</div>

<div class="new_area">
  <div class="container">
  	<div class="row">
  	<div class="col-12">
		 <h1 class="title">새로운 상품</h1>
	 </div>
  	<c:forEach var="goodsFileVO" items="${listNew}" varStatus="status">
  	<c:choose>
	 	<c:when test="${goodsFileVO.goodsDto.goods_stock>0}">
	 		<div class="col-lg-4 goods_box">
  			<a class="goods_img" href="goods/goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
  			</a>
	  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}</p>
	  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
	  		<p class="goods_price">
	  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber></p>
	  		<div class="star-wrap" data-limit="5" data-unitsize="20" data-point="${starListNew[status.index]}" data-image="http://www.sysout.co.kr/file/image/288" data-readonly></div>
  		</div>
	 	</c:when>
	 	<c:otherwise>
	  		<div class="col-lg-4 goods_box soldout">
	  			<a class="goods_img" href="goods/goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
	  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
	  			</a>
	  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}<span class="badge badge-secondary">품절</span></p>
	  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
	  		<p class="goods_price">
	  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber></p>
	  		<div class="star-wrap" data-limit="5" data-unitsize="20" data-point="${starListNew[status.index]}" data-image="http://www.sysout.co.kr/file/image/288" data-readonly></div>
	  		</div>
	 	</c:otherwise>
	</c:choose>
	</c:forEach>
  	</div>
  </div>
</div>

<!-- 전체  -->
<div class="all_area">
  <div class="container">
  	<div class="row">
  	<div class="col-12">
		 <h1 class="title">모든 상품</h1>
	 </div>
  	<c:forEach var="goodsFileVO" items="${list}" varStatus="status">
  		<c:choose>
		 	<c:when test="${goodsFileVO.goodsDto.goods_stock>0}">
		 		<div class="col-lg-4 goods_box">
		  			<a class="goods_img" href="goods/goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
		  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
		  			</a>
			  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}</p>
			  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
			  		<p class="goods_price">
			  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber></p>
			  		<div class="star-wrap" data-limit="5" data-unitsize="20" data-point="${starList[status.index]}" data-image="http://www.sysout.co.kr/file/image/288" data-readonly></div>
	  			</div>
		 	</c:when>
		 	<c:otherwise>
		  		<div class="col-lg-4 goods_box soldout">
		  			<a class="goods_img" href="goods/goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
		  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
		  			</a>
			  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}<span class="badge badge-secondary">품절</span></p>
			  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
			  		<p class="goods_price">
			  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber></p>
			  		<div class="star-wrap" data-limit="5" data-unitsize="20" data-point="${starList[status.index]}" data-image="http://www.sysout.co.kr/file/image/288" data-readonly></div>
		  		</div>
		 	</c:otherwise>
 		</c:choose>
	</c:forEach>
  	</div>
  </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>