<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script>
$(function(){
	$(".goods_box").click(function(){
		var url = $(this).children(".goods_img").attr("href");
		$(location).attr('href', url);
	});
	
	// 품절 경고
	$(".soldout").click(function(){
		window.alert("품절된 상품입니다.");
	});
	
	// 검색 결과에 따른 위치 처리
	if('${listSize}'<1) {
		var text = $("<h1 class='text'>검색 결과가 없습니다!</h1>");
		$(".goods_area").append(text);
		$(".goods_area").addClass("justify-content-center");
	} else {
		$(".goods_area").removeClass("justify-content-center");
	}
	
	
});
</script>
</head>

<style>
.goods_area {
	margin: 80px 0px;
}

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
<hr>
<div class="search_area">
  <p class="h2 text-center">검색 결과</p>
  <hr>
  <div class="container">
  	<div class="row goods_area">
  	<c:forEach var="goodsFileVO" items="${list}">
  		<c:choose>
		 	<c:when test="${goodsFileVO.goodsDto.goods_stock>0}">
		 		<div class="col-lg-4 goods_box">
  			<a class="goods_img" href="${pageContext.request.contextPath}/goods/goodsInfo?goods_no=${goodsFileVO.goodsDto.goods_no}">
  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
  			</a>
	  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}</p>
	  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
	  		<p class="goods_price">
	  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber></p>
	  		</div>
		 	</c:when>
		 	<c:otherwise>
		  		<div class="col-lg-4 goods_box soldout">
		  			<a class="goods_img" href="#">
		  				<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${goodsFileVO.goods_main_image}">
		  			</a>
		  		<p class="goods_name">${goodsFileVO.goodsDto.goods_name}<span class="badge badge-secondary">품절</span></p>
		  		<p class="goods_content text-truncate">${goodsFileVO.goodsDto.goods_content}</p>
		  		<p class="goods_price">
		  		<fmt:formatNumber pattern="###,###,###" type="number">${goodsFileVO.goodsDto.goods_price}</fmt:formatNumber></p>
		  		</div>
		 	</c:otherwise>
 		</c:choose>
	</c:forEach>
  	</div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>







