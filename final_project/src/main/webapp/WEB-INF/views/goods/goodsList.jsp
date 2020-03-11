<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">

<script>
$(function(){
	$(".goods_main_image").change(function(){
		
		var index = $(this);
		var form = $(this).children(".main_image_form");
		var data = form.serialize();
		
		$.ajax({
			type: "POST",
			url: "../goods/updateMainImage",
			data:data,
			success: function(files_no){
				index.children(".main_image").attr("src", '${pageContext.request.contextPath}'+"/goods/mainImageDown?files_no="+files_no);
			}
		});
	});
	
	// 이미지 미리보기
// 	var sel_file;
	
// 	$(".goods_main_image").each(function(){
// 		var index = $(this);
// 		$(this).on("change",handleImgFilesSelect);	
	
	
// 		function handleImgFilesSelect(e) {
// 			var files = e.target.files;
// 			var filesArr = Array.prototype.slice.call(files);
			
// 			filesArr.forEach(function(f){
// 				if(!f.type.match("image.*")){
// 					alert("이미지만 가능합니다");
// 					return;
// 				}
				
// 				sel_file = f;
				
// 				var reader = new FileReader();
// 				reader.onload = function(e) {
// 					index.parent().siblings(".main_image").attr("src", e.target.result);
// 				}
// 				reader.readAsDataURL(f);
// 			});
// 		}
// 	});
	
	$(".main_image").click(function(){
		$(this).siblings(".goods_main_image").click();
	});
});
	
</script>

<style>
.main_image_box {
	cursor: pointer;
}
</style>

${goodsList}


<table class="table table-borderless">
	<tbody>
		<tr>
			<th scope="col" style="width: 15%">대표이미지</th>
			<th scope="col" style="width: 30%">상품정보</th>
			<th scope="col" style="width: 15%">수량</th>
			<th scope="col" style="width: 20%">가격</th>
			<th scope="col" style="width: 15%">-</th>
		</tr>
		<c:forEach items="${goodsList}" var="goodsDto" varStatus="status">
			<tr>
				<td class="main_image_box">
					<img class="main_image" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${filesList[status.index]}">
					<form method="POST" class="main_image_form">
						<input type="file" class="main_image_file goods_main_image" name="goods_main_image">
						<input type="hidden" name="goods_no" value="${goodsDto.goods_no}">
					</form>
				</td>
				<td>
					<div class="align-middle">
						<h5>${goodsDto.goods_name}</h5>
						<span>${goodsDto.goods_content}</span>
					</div>
				</td>
				<td>
					<p class="text-truncate">${goodsDto.goods_stock} 개</p>
				</td>
				<td>
					<fmt:formatNumber pattern="###,###,###" type="number">${goodsDto.goods_price}</fmt:formatNumber> 원<br>
				</td>
				<td>
					<button>상세수정</button>
				</td>
			</tr>
		</c:forEach>
	</tbody>
 </table>