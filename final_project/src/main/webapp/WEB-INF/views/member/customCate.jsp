<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta http-equiv="X-UA-Compatible" content="ie=edge" />

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
 
 <style>
 /*	footer */
	footer div {
		bottom: 0;
		width: 100%;
		height: 130px;
		background-color: rgb(248,245,240);
		padding: 15px 0 ;
	}
	.footer_area * {
		list-style: none;
		padding: 0;
	}
	.footer_area ul {
		float: left;
		position: relative;
		margin: 0 10px;
	}
	.footer_title {
		padding-bottom: 70px ;
		width: 30%;
		text-align: right;
		padding-right: 10px;
	}
	.footer_company {
		width: 30%;
	}
	.footer_cs {
		width: 30%;
		float: right:
	}

/*	부트스트랩 nav */
	.navbar {
	    padding: 3px 1rem;
	}
	.navbar .nav-link {
		margin: 5px 0;
	    padding: 0 2rem;
	    border-left: 1px solid rgba(255,255,255,0.1);
	    border-right: 1px solid rgba(0,0,0,0.2);
	    font-size: 13px;
	}
 
/*	customCate.jsp style*/
 	.articleBox {
 		width: 500px;
 		height: 800px;
		margin: 0 auto;
	}
 	.insert_cate,
 	.insert_req  {
 		width: 90%;
 	}
 	.insert_req * {
 		width: 100%;
 	}
 	.text-primary {
 		font-weight: bold; 
 	}
 	.insert_req > textarea {
 		resize: none;
 		height: 25%;
 	}
 	.insert_req input[type=submit] {
 		height: 50px;
 	}
 	.btn_next {
 		border: 1px solid darkgray;
 		background-color: white;
 	}
	.btn_next:focus {
 		outline: none;
 	}
 	
 	/* a태그 하이퍼링크 표시 제어 */
    .sellerList a:link { text-decoration: none;}
    .sellerList a:visited { text-decoration: none;}
    .sellerList a:hover { text-decoration: none;}
 </style>
 
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
		 			 
		 			var btn_next = document.querySelector(".btn_next");
 			 		 $(btn_next).attr("disabled", false);
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

					var p = $("<p><a href='#' title='최근 한 달간 판매량 순'>&check; 추천 판매자</a>를 선택하시면 1:1 개인요청서로 전환됩니다.</p>");
					$(".sellerList").append(p); 
	  			 		
					$.each(resp, function(index, item){
						var seller = $("<a href='${pageContext.request.contextPath}/member/customOrder?seller_no="+item.seller_no+"'>"+item.seller_id+"</a><br>");
						$(".sellerList").append(seller);
					});

  			 		 var btn_next = document.querySelector(".btn_next");
  			 		 $(btn_next).attr("disabled", false);
  			 		 
  			 	 }
  			 });
 		 });
 	///////////////// 요청서 입력창 스타일 제어
 		$(".btn_next").click(function(){
 			var category_large = document.querySelector(".customCate");
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
<article class="articleBox">
<div class="customCate" style="display:block;">
	<form action="customCate" method="post" enctype="multipart/form-data"
				onsubmit="return confirm('추후 판매자가 확인하지 않은 요청서만 삭제할 수 있습니다. 요청서를 보내시겠습니까?');">
		<div class="insert_cate form-group">
			<h6 class="text-secondary">요청서를 보낼 기본 카테고리를 선택해주세요.</h6>
			<select class="category_large form-control" name="category_large" required>
				<option class="largeChild" value="">선택</option>
			</select>
			<p></p>
			<select class="category_middle form-control" name="category_middle" required>
				<option class="middleChild" value="">선택</option>
			</select>
			<p></p>
			<select class="category_small form-control" name="category_name" required>
				<option class="smallChild" value="">선택</option>
			</select>
			<p></p>
			<div class="sellerList">
			</div>
		</div>
		<div class="insert_req" style="display:none;">
 			<input type="hidden" name="member_no" value="${member_no }">
 			<h6 class="text-secondary">요청서 제목을 작성해주세요.</h6>
			<input class="input_req form-control" type="text" name="custom_order_title" placeholder="요청서 제목" required>
				<br>
			<h6 class="text-secondary">요청하는 상세내용을 작성해주세요.</h6>
			<textarea class="input_req form-control" name="custom_order_content" required></textarea>
				<br>
			<h6 class="text-secondary">희망 가격은 얼마인가요?</h6>
			<input class="input_req form-control" type="number" name="custom_order_price" placeholder="원" required>
				<br>
			<h6 class="text-secondary">희망 날짜는 언제인가요? </h6>
			<input class="input_req form-control" type="date" name="custom_order_hopedate" required>
				<br>
			<h6 class="text-secondary">원하는 디자인 등이 있다면 함께 보내주세요.</h6>
			<input class="input_req form-control-file" type="file" name="files" multiple>
				<br>
			<input class="input_req form-control btn btn-primary" type="submit" value="요청서 보내기">
		</div>
	</form>
		<button type="button" class="btn_next" disabled>다음</button>
</div>
</article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>