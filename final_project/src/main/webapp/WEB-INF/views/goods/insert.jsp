<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8" />
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta http-equiv="X-UA-Compatible" content="ie=edge" />
 <script src="https://code.jquery.com/jquery-latest.js"></script>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
 <script src="${pageContext.request.contextPath}/resources/js/goodsOption.js"></script>
 <script>
 $(function(){
////////////	카테고리	///////////////////////////////////
	 var category_largeList = "${category_largeList}";
	 category_largeList = category_largeList.substring(1, category_largeList.length-1).split(",");
	 $.each(category_largeList, function(index, item){
		 var option = $("<option value='"+item+"'>"+item+"</option>");
		 $(".category_large").append(option);
	 });
	 
	 $(".category_large").change(function(){
		 $(".middleChild").nextAll().remove();
		 $(".smallChild").nextAll().remove();
		 var category_name = $(this).val();
		 var url = "large";
		 $.ajax({
			 type: "POST",
		 	 url: url,
		 	 data: {"category_name":category_name},
		 	 success: function(resp){
		 		 $.each(resp, function(index, item){
		 			var option = $("<option value='"+item+"'>"+item+"</option>");
		 			$(".category_middle").append(option);
		 		 });
		 	 }
		 });
	 });
 		 
	 $(".category_middle").change(function(){
		$(".smallChild").nextAll().remove();
		 var category_name = $(this).val();
		 var url = "middle";
		 $.ajax({
			 type: "POST",
		 	 url: url,
		 	 data: {"category_name":category_name},
		 	 success: function(resp){
		 		 $.each(resp, function(index, item){
		 			var option = $("<option value='"+item+"'>"+item+"</option>");
		 			$(".category_small").append(option);
		 		 });
		 	 }
		 });
	 });
		 
	 $(".category_small").change(function(){
		var category_name = $(this).val();
		 console.log(category_name);
		 var url = "small";
		 $.ajax({
			 type: "POST",
		 	 url: url,
		 	 data: {"category_name":category_name},
		 	 success: function(resp){
	 			 $(".category_no").val(resp);
		 	 }
		 });
	 });
//////////////////////////////////////////////////////////////////////		 
 		 
 		
	// 이미지 미리보기
	var sel_file;
	
	$(".goods_main_image").on("change",handleImgFilesSelect);
	
	function handleImgFilesSelect(e) {
		console.log("ok");
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("이미지만 가능합니다");
				return;
			}
			
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				console.log(e.target.result);
				console.log(e);
				$(".main_image").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
});
 </script>
<style>
ul{
   list-style:none;
   padding-left:0px;
}

.main_image_box{
	width: 100%;
	height: 250px;
	margin-bottom: 10px;
}

.main_image_box > img {
	width: 100%;
	height: 250px;
}

.goods_name_box {
	margin-bottom: 15px;
}

.goods_price_box {
	margin: 10px 0px;
}

.goods_stock_box {
	margin: 10px 0px;
}

.goods_status_box {
	margin: 10px 0px;
}

.goods_category {
	margin: 10px 0px;
}

.goods_content_box {
	margin: 10px 0px;
}

</style>
</head>
<body>

<form action="insert" method="post" enctype="Multipart/form-data">
	<div class="container">
		<h1 class="text-center">상품 등록 페이지</h1>
		<div class="row justify-content-center">
			<div class="col-lg-8">
					<div class="row goods_name_area">
						<div class="col">
							<div class="input-group goods_name_box">
							  <div class="input-group-prepend">
							    <span class="input-group-text" id="inputGroup-sizing-default">상품명</span>
							  </div>
							<input type="text" class="form-control" name="goods_name" required>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-6">
							<div class="main_image_box">
								<img class="main_image rounded" src="https://placehold.it/291x250/E8117F/ffffff?text=image">
							</div>
							<div class="input-group">
							  <div class="input-group-prepend">
							    <span class="input-group-text" id="inputGroupFileAddon01">대표사진</span>
							  </div>
							  <div class="custom-file">
							    <input type="file" class="custom-file-input goods_main_image" name="goods_main_image" required>
							    <label class="custom-file-label" for="inputGroupFile01">파일 찾기</label>
							  </div>
							</div>
						</div>					
						<div class="col-lg-6">
						<div class="input-group goods_price_box">
							<div class="input-group-prepend">
							    <span class="input-group-text">상품가격</span>
						    </div>
							<input type="text" class="form-control" name="goods_price" required>
						</div>
						<div class="input-group goods_stock_box">
							<div class="input-group-prepend">
							    <span class="input-group-text" id="inputGroup-sizing-default">상품수량</span>
						    </div>
							<input type="text" class="form-control" name="goods_stock" required>
						</div>	
						<div class="input-group goods_status_box">
							<div class="input-group-prepend">
							    <span class="input-group-text">판매여부</span>
						    </div>
							<select name="goods_status" class="form-control">
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</div>
						<div class="input-group goods_category">
							<div class="input-group-prepend">
							    <span class="input-group-text">대</span>
							</div>
							<select class="form-control category_large inline-block" name="category_middle">
									<option class="largeChild">선택</option>
							</select>
						</div>
						<div class="input-group goods_category">
							<div class="input-group-prepend">
							    <span class="input-group-text">중</span>
							</div>
							<select class="form-control category_middle" name="category_middle">
									<option class="middleChild">선택</option>
							</select>
						</div>
						<div class="input-group goods_category">
							<div class="input-group-prepend">
							    <span class="input-group-text">소</span>
							</div>
							<select class="form-control category_small" name="category_middle">
									<option class="smallChild">선택</option>
							</select>
						</div>
						<input class="category_no" type="hidden" name="category_no" value="">			
						</div>	
					</div>
					
					
				<div class="form-group goods_content_box">
			      <label class="input-group-text" for="content">상품 설명</label>
			      <textarea class="form-control" id="content" rows="3" name="goods_content"></textarea>
			    </div>
				
				
				<div class="form-group">
			      <label for="">옵션</label><br>
					<button type="button" class="addOptionBtn btn btn-secondary btn-sm">옵션 추가</button>
				    <ul class="optionArea">
				    </ul>
			    </div>	
				
				
				<p>상품사진</p>
				<input type="file" multiple="multiple" name="goods_content_image">
				
				<h1>배송 정보 입력</h1>
				<div class="input-group">
					<div class="input-group-prepend">
					    <span class="input-group-text">배송여부</span>
					</div>
					<select class="form-control" name="delivery_agree">
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
				</div>
				
				<div class="input-group">
					<div class="input-group-prepend">
					    <span class="input-group-text">묶음배송여부</span>
					</div>
					<select class="form-control" name="delivery_set_agree">
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
				</div>
				<div class="input-group">
					<div class="input-group-prepend">
					    <span class="input-group-text">묶음배송 조건금액</span>
					</div>
					<input class="form-control" required type="text" name="delivery_set_op_price">
				</div>
				<div class="input-group">
					<div class="input-group-prepend">
					    <span class="input-group-text">택배회사</span>
					</div>	
					<select class="form-control" name="delivery_company">
						<option>선택</option>
						<option value="우체국">우체국</option>
						<option value="한진">한진</option>
						<option value="로젠">로젠</option>
					</select>
				</div>
				<div class="input-group">
					<div class="input-group-prepend">
					    <span class="input-group-text">배송조건</span>
					</div>
					<select class="delivery_option form-control" name="delivery_option">
						<option>선택</option>
						<option value="무료">무료</option>
						<option value="유료">유료</option>
						<option value="조건부무료">조건부무료</option>
					</select>
				</div>
				<div class="input-group delivery_price">
					<div class="input-group-prepend">
					    <span class="input-group-text">배송비</span>
					</div>
						<input class="form-control" required type="text" name="delivery_price" value="0">
				</div>
				<div class="input-group delivery_op_price">
					<div class="input-group-prepend">
					    <span class="input-group-text">조건부 무료 금액</span>
					</div>
						<input class="form-control" required type="text" name="delivery_op_price" value="0">
				</div>
				<div class="input-group">
					<div class="input-group-prepend">
					    <span class="input-group-text">반품 배송비</span>
					</div>
					<input class="form-control" required type="text" name="delivery_return_price">
				</div>
					<h5 class="submit_comment" style="color:red">기본옵션을 추가해주세요</h5>
					<input class="form-control" class="submit_btn" type="submit" value="등록" disabled>
				</div>
		</div>
	</div>
	<input type="hidden" name="seller_no" value="${seller_no}">
	<input type="hidden" name="goods_discount_price" value="0" required>
	<input type="hidden" name="goods_discount_start" value="2020-02-25" required>
	<input type="hidden" name="goods_discount_finish" value="2020-02-25" required>

</form>

</body>
</html>