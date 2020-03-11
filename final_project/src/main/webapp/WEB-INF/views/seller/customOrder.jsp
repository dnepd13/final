<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
 	.insert_resp textarea {
 		resize: none;
 		height: 25%;
 	}
 	.insert_resp > input[type=submit] {
 		height: 50px;
 	}
 	
 	table td {
 		padding: 1px 5px;
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
			if($(this).val()<=0 || $(this).val()>1000000){
				$(this).val("");
				alert("견적 가격은 1원 이상, 100만원 이하로 작성해주세요.");
			}
		});
		
		// 파일정보 미리보기
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
		<h6 class="text-secondary">예상 견적은 얼마인가요? (배송비 포함)</h6>
		<input class="input_req form-control price" type="number" name="custom_order_price" placeholder="원">
			<br>
		<h6 class="text-secondary">언제까지 가능한가요?</h6>
		<input class="input_req form-control date" type="text" name="custom_order_hopedate" required readonly>
			<br>
		<h6 class="text-secondary">샘플 디자인 등이 있다면 업로드해주세요.
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
		<input class="input_req form-control btn btn-primary" type="submit" value="견적서 보내기">
	</form>
</div>
</article>