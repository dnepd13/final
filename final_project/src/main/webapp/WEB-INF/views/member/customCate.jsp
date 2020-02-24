<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta http-equiv="X-UA-Compatible" content="ie=edge" />
 <script src="https://code.jquery.com/jquery-latest.js"></script>

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
	 		 $(".sellerList").children().remove();
 			 var category_name = $(this).val();
 			 var url = "${pageContext.request.contextPath}/goods/large";
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
 			$(".sellerList").children().remove();
			 var category_name = $(this).val();
			 var url = "${pageContext.request.contextPath}/goods/middle";
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
 			$(".sellerList").children().remove();
 			var category_name = $(this).val();
			 var url = "${pageContext.request.contextPath}/goods/small";
			 $.ajax({
				 type: "POST",
			 	 url: url,
			 	 data: {"category_name":category_name},
			 	 success: function(resp){
		 			 $(".category_no").val(resp);
			 	 }
			 });
 		 });
 		 
 		 $(".category_small").change(function(){
   			var category_name = $(this).val();

  			 var url = "${pageContext.request.contextPath}/member/pick";
  			 $.ajax({
  				 type: "POST",
  			 	 url: url,
  			 	 data: {"category_name":category_name},
  			 	 success: function(resp){			 		 
  			 		 var p = $("<p>추천 판매자를 선택하시면 1:1 개인요청서로 전환됩니다.</p>")
  			 		 
  			 		 $(".sellerList").append(p);
  			 		 
  			 		$.each(resp, function(index, item){
  			 			var seller = $("<a href='${pageContext.request.contextPath}/member/customOrder?seller_no="+item.seller_no+"'>"+item.seller_id+"</a><br>");
  			 			$(".sellerList").append(seller);
 			 		 });
  			 		
  			 	 }
  			 });
 		 });
 	///////////////// 요청서 입력창 스타일 제어
 		$(".btn_next").click(function(){
            var insert_req = document.querySelector(".insert_req");

            if($(this).text()=="다음"){
                insert_req.style.display="block";
                $(".insert_cate").hide();
                $(this).text("이전");
            }
            else{
                insert_req.style.display="none";
                $(".insert_cate").show();
                $(this).text("다음");
            }
        });
 		
 		$(".redirect").hide();

	});

 </script>
 
<h3>member/customoCate.jsp 카테고리 주문제작 페이지</h3>

<br><br>

<!-- 카테고리 선택페이지 -->
<div class="customCate" style="display:block;">
	<h5>요청서를 보낼 기본 카테고리를 선택해주세요.</h5>
	<form action="customCate" method="post" enctype="multipart/form-data"
				onsubmit="return confirm('추후 판매자가 확인하지 않은 요청서만 삭제할 수 있습니다. 요청서를 보내시겠습니까?');">
		<div class="insert_cate">
			<select class="category_large" name="category_large">
				<option class="largeChild">선택</option>
			</select>
			<select class="category_middle" name="category_middle">
				<option class="middleChild">선택</option>
			</select>
			<select class="category_small" name="category_name">
				<option class="smallChild" value="">선택</option>
			</select>
			<div class="sellerList">
			</div>
		</div>
		<div class="insert_req" style="display:none;">
 			<input type="hidden" name="member_no" value="${member_no }">
			<input type="text" name="custom_order_title" placeholder="요청서 제목" required>
			<h5>요청하는 상세내용을 작성해주세요.</h5>
			<textarea name="custom_order_content" required></textarea>
			<h5>희망 가격은 얼마인가요?</h5>
			<input type="number" name="custom_order_price" placeholder="원" required>
			<h5>희망 날짜는 언제인가요? </h5>
			<input type="date" name="custom_order_hopedate" required>
			<h5>원하는 디자인 등이 있다면 함께 보내주세요.</h5>
			<input type="file" name="files" multiple>
				<br><br>
			<input type="submit" value="요청서 보내기">
		</div>
	</form>
		<button type="button" class="btn_next">다음</button>
</div>