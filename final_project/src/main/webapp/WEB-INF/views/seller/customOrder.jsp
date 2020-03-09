<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    

 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
 
 <style>
 	.articleBox {
 		width: 500px;
		margin: 0 auto;
	}
 	.insert_resp {
 		width: 90%;
 	}
 	.insert_resp > * {
 		width: 100%;
 	}
 	.text-primary {
 		font-weight: bold; 
 	}
 	.insert_resp > textarea {
 		resize: none;
 		height: 25%;
 	}
 	.insert_resp > input[type=submit] {
 		height: 50px;
 	}
 	
 </style>

<script src="https://code.jquery.com/jquery-latest.js"></script>
 <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script>
	$(function(){
		
		$(".date").datepicker({ 
			minDate: 0,
			dateFormat: "yy/mm/dd"
		});
		
		$(".price").keyup(function(){
			console.log($(this).val());
			if($(this).val()<=0){
				$(this).val("");
				alert("견적가격을 다시 확인해주세요");
			}
		});
		
	});
</script>

<h3>판매자 주문제작 seller/customOrder.jsp</h3>
<br><br>
<h3>견적서</h3>
<article class="articleBox">
<div class="insert_resp">
	<form action="customOrder" method="post" enctype="multipart/form-data"
				onsubmit="return confirm('추후 요청자가 확인하지 않은 견적서만 삭제할 수 있습니다. 견적서를 보내시겠습니까?');">
		<input type="hidden" name="category_no" value=${category_no }>
		<input type="hidden" name="member_custom_order_no" value="${member_custom_order_no }">
		<h6 class="text-secondary">견적서 제목을 작성해주세요.</h6>
		<input class="input_req form-control" type="text" name="custom_order_title" placeholder="견적서 제목" required>
			<br>
		<h6 class="text-secondary">견적서의 상세내용을 작성해주세요.</h6>
		<textarea class="input_req form-control" name="custom_order_content" required></textarea>
			<br>
		<h6 class="text-secondary price">예상 견적은 얼마인가요? (배송비 포함)</h6>
		<input class="input_req form-control" type="number" name="custom_order_price" placeholder="원">
			<br>
		<h6 class="text-secondary">언제까지 가능한가요?</h6>
		<input class="input_req form-control date" type="text" name="custom_order_hopedate" required readonly>
			<br>
		<h6 class="text-secondary">샘플 디자인 등이 있다면 업로드해주세요.</h6>
		<input class="input_req form-control-file" type="file" name="files" multiple>
			<br>
		<input class="input_req form-control btn btn-primary" type="submit" value="견적서 보내기">
	</form>
</div>
</article>