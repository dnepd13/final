<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta http-equiv="X-UA-Compatible" content="ie=edge" />

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

 <style>
/*	customCate.jsp style*/
 	.articleBox {
 		width: 500px;
 		height: 1000px;
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
 		height: 300px;
 	}
 	.insert_req input[type=submit] {
 		height: 50px;
 	}
 	.btn_custom {
 		border: 1px solid darkgray;
 		background-color: white;
 	}
	.btn_custom {
 		outline: none;
 	}
 	
 	/* a태그 하이퍼링크 표시 제어 */
    .sellerList a:link { text-decoration: none;}
    .sellerList a:visited { text-decoration: none;}
    .sellerList a:hover { text-decoration: none;}
 </style>
 
<script src="https://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

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
 		 
 		var urlSeller = "${pageContext.request.contextPath}/member/sellerPick";
 		 $(".category_small").change(function(){
   			var category_name = $(this).val();
   			
   			$.ajax({
 				 type: "POST",
 			 	 url: urlSeller,
 			 	 data: {"category_name":category_name},
 			 	 success: function(resp){

					if(resp.length==0){
						var p = $("<p>현재 카테고리의 요청서를 허용한 판매자가 없습니다.</p>");
						$(".sellerList").append(p);
						
						var btn_next = document.querySelector(".btn_next");
	  			 		 $(btn_next).attr("disabled", true);
					}
					else{
						var btn_next = document.querySelector(".btn_next");
	  			 		 $(btn_next).attr("disabled", false);
					}
				}
   			});
 		 
  			 var url = "${pageContext.request.contextPath}/member/bestPick";
  			 $.ajax({
  				 type: "POST",
  			 	 url: url,
  			 	 data: {"category_name":category_name},
  			 	 success: function(resp){

					if(resp.length>0){
						var p = $("<p><a href='#' title='최근 한 달간 판매량 순'>&check; 추천 판매자</a>를 선택하시면 1:1 개인요청서로 전환됩니다.</p>");
						$(".sellerList").append(p); 
		  			 		
						$.each(resp, function(index, item){
							var seller = $("<a href='${pageContext.request.contextPath}/member/customOrder?seller_no="+item.seller_no+"'>"+item.seller_id+"</a><br>");
							$(".sellerList").append(seller);
						});

	  			 		 var btn_next = document.querySelector(".btn_next");
	  			 		 $(btn_next).attr("disabled", false);
					}
  			 		 
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

	$(function(){
 				
		$(".date").datepicker({ 
			minDate: 0,
			dateFormat: "yy/mm/dd"
		});
 		
		$(".price").keyup(function(){
			if($(this).val()<=0 || $(this).val()>1000000){
				$(this).val("");
				alert("희망가격은 1원 이상, 100만원 이하로 작성해주세요.");
			}
		});
		
		// 파일정보 미리보기
		var upload = document.querySelector("#upload");
		
		$(upload).change(function(f){
			$(".files_Info").children().empty();
			var files = f.target.files;	
			if(files.length >5 ){
				alert("파일은 최대 5개까지만 등록 가능합니다. 다시 선택해주세요.");
				$("input[type=submit]").prop("disabled", true);
			}
			else{
				$("input[type=submit]").prop("disabled", false);
				for(var i=0 ; i<files.length ; i++){
					var filesName =files[i].name;
					var filesSizeOrigin = files[i].size/1024;
					var filesSize = String(filesSizeOrigin).substring(0,5);
					$(".files_name").append(filesName+"<br>");
					$(".files_size").append(filesSize+" KB <br>");
				}
			}
		});
		
	});
	
	// 입력창 글자 수 제한
	$(function(){

		$(".custom_order_title").keyup(function(){
			var text_length=$(this).val().length; // 입력된 글자 수 길이
			var max_length=30; // 제한할 max 길이
	
			if(text_length>max_length){
				alert("제목은 30자를 초과할 수 없습니다.");
				non_pass(); // non_pass() 함수 호출
			}	
			else{
				pass();  // pass() 함수 호출
			}
		});
		
		$(".custom_order_content").keyup(function(){
			var text_length=$(this).val().length;
			var max_length=1000;
			
			htmls="";
			htmls+=text_length;
			$(".text_limit").html(htmls);
			
			if(text_length>max_length){
				alert("상세내용은 "+max_length+"자를 초과할 수 없습니다.");
				non_pass();
			}
			else{
				pass();
			}
		});
		// 날짜 입력 길이  제한
		$(".date").keyup(function(){

			var text_length=$(this).val().length;
			var max_length=10;
			
			if(text_length>max_length){				
				alert("날짜는 2020/01/01 의 형태로 입력해주세요.");
				non_pass();
			}
			else{
				pass();
			}
		});
		
		function non_pass(){
			$(".btn_send").prop("disabled", true); // submit 버튼 비활성화
		}
		function pass(){
			$(".btn_send").prop("disabled", false);
		}

	});

 </script>
 
<div class="row-empty-40"></div>

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
 			<h6 class="text-secondary">요청서 제목을 작성해주세요. (30자 이내)</h6>			
			<input class="input_req form-control custom_order_title" type="text" name="custom_order_title" placeholder="요청서 제목" required>
				<br>
			<h6 class="text-secondary">요청하는 상세내용을 작성해주세요.</h6>
			<textarea class="input_req form-control custom_order_content" name="custom_order_content" required></textarea>
			<p align="right">(<span class="text_limit"></span> / 1000)</p>
			<h6 class="text-secondary">희망 가격은 얼마인가요?</h6>
			<input class="input_req form-control price" type="number" name="custom_order_price" placeholder="원" required>
				<br>
			<h6 class="text-secondary">희망 날짜는 언제인가요? </h6>
			<input class="input_req form-control date" type="text" name="custom_order_hopedate" required>
				<br>
			<h6 class="text-secondary">원하는 디자인 등이 있다면 함께 보내주세요.
															<small id="emailHelp" class="form-text text-muted">(이미지 파일만 등록 가능합니다.)</small>
			</h6>
			<input class="input_req form-control-file" type="file" name="files" id="upload" multiple accept="image/all">
			<!-- 파일정보 미리보기 영역-->
			  <div>
			  	<table>
			  		<tbody>
			  			<tr class="files_Info">
			  				<td class="files_name" style="width:70%;"></td>
			  				<td class="files_size" style="width:30%;"></td>
			  			</tr>
			  		</tbody>
			  	</table>
			  </div>
				<br>
			<input class="input_req form-control btn btn-primary btn_send" type="submit" value="요청서 보내기">
		</div>
	</form>
		<button type="button" class="btn_next btn_custom" disabled>다음</button>
</div>
</article>

<div class="row-empty-40"></div> 

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>