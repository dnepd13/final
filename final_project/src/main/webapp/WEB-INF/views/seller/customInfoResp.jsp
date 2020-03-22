<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 

<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>
 
 <style>
 	.articleBox {
 		width: 500px;
		margin: 0 auto;
	}
	
 	.insert_req  {
 		width: 90%;
 		margin: 0 auto;
 	}
 	.insert_req * {
 		width: 100%;
 	}
 	.text-primary {
 		font-weight: bold; 
 	}
 	.insert_req textarea{
 		resize: none;
 		height: 25%;
 	}
 	.insert_req input[type=submit] {
 		height: 50px;
 	}
 	
 	.btn_update {
 		border: 1px solid darkgray;
 		background-color: white;
 	}
	.btn_update:focus {
 		outline: none;
 	}
 	
 /* 수정 modal 전체 스타일 */
 	.modal {
 		display: none;
 		z-index: 1;
 		top: 0;
 		bottom: 0;
 		letf: 0;
 		right: 0;
 		background-color: rgba(0,0,0,0.3);
 	}
 </style>

<script src="https://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(function(){
	// 수정 modal 제어
		var btn_update = document.querySelector(".btn_update");
		var modal = document.querySelector(".modal");
		var close = document.querySelector(".close");
		
		var alarm = $(".btn_update").data("alarm_check");

		if(alarm=="N"){
			$(".btn_update").prop("disabled", false);
			$(btn_update).click(function(){
				modal.style.display = "block";
			});
		}
		else if (alarm=="Y"){
			$("btn_update").prop("disabled", true);
			btn_update.style.color = "#BDBDBD";
		}
		
		$(close).click(function(){
			modal.style.display = "none";
		});
		
		// 달력
		$(".date").datepicker({ 
			minDate: 0,
			dateFormat: "yy/mm/dd"
		});
		
		// 가격 입력제한
		$(".price").keyup(function(){

			if($(this).val()<=0 || $(this).val()>1000000){
				$(this).val("");
				alert("희망가격은 1원 이상, 100만원 이하로 작성해주세요.");
			}

		});
		
	// modal 바깥의 윈도우 클릭 시 modal 닫음		
// 	window.onclick = function(event){
// 		if(event.target == modal){
// 			modal.style.display = "none";
// 		}
// 	}
	
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

<article class="articleBox">

<div class="card mb-3">
	<div class="card-header">
		<h5>${getListInfoResp.custom_order_title }</h5>
		<h6 class="card-subtitle text-muted">
			<span>
			${member_id } 님에게 보낸 견적서
			</span>
			<span style="float:right;">
				<fmt:parseDate value="${getListInfoResp.custom_order_date }" var="custom_order_date" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${custom_order_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
			</span><br>
			<span style="float:right;">${getListInfoResp.custom_order_status }</span>
		</h6>
	</div>
	<div class="card-body cart-text">
		<p>${getListInfoResp.custom_order_content }</p>
		<hr>
	</div>
	<c:if test="${ not empty filesVO }">
		<div align="center">
			<c:forEach var="filesVO" items="${filesVO }">
				<img src="http://localhost:8080/ordering/seller/download?files_no=${filesVO.files_no }" width=50%; height=auto;>
			</c:forEach>
		</div>
		<hr>
	</c:if>
	<ul class="list-group list-group-flush">
		<li class="list-group-item card-text">
			<h6 class="card-subtitle text-muted">견적가격&Tab;</h6>
				<fmt:formatNumber pattern="###,###,###" type="number">
					${getListInfoResp.custom_order_price } 
				</fmt:formatNumber> 원
			</li>
		<li class="list-group-item card-text">
			<h6 class="card-subtitle text-muted">가능날짜&Tab;</h6>
			${getListInfoResp.custom_order_hopedate }
			</li>
	</ul>
	<div class="card-footer text-muted content_last" align="right">
		<button class="btn_update" data-alarm_check="${alarm.member_alarm_check }" disabled>
			수정
		</button>
		<a href="${pageContext.request.contextPath }/seller/customListResp">목록으로</a>		
	</div>
</div>

<!-- 수정 modal -->
<div class="modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
<!--         <h5 class="modal-title">Modal title</h5> -->
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="insert_req update_form modal-body">
		<form action="updateResp" method="post">
			<input type="hidden" name="category_no" value=${category_no }>
			<input type="hidden" name="custom_order_no" value="${getListInfoResp.custom_order_no }">
			<input type="hidden" name="seller_custom_order_no" value="${getListInfoResp.seller_custom_order_no }">
			
			<h6 class="text-secondary">견적서 제목을 작성해주세요.</h6>
			<input class="input_req form-control custom_order_title" type="text" name="custom_order_title" placeholder="${getListInfoResp.custom_order_title }" required>
				<br>
			<h6 class="text-secondary">견적서의 상세내용을 작성해주세요.</h6>
			<textarea class="input_req form-control custom_order_content" name="custom_order_content" placeholder="${getListInfoResp.custom_order_content }" required></textarea>
				<br>
			<h6 class="text-secondary">예상 견적은 얼마인가요?</h6>
			<input class="input_req form-control price" type="number" name="custom_order_price" placeholder="${getListInfoResp.custom_order_price}" required>
				<br>
			<h6 class="text-secondary">언제까지 가능한가요? </h6>
			<input class="input_req form-control date" type="text" name="custom_order_hopedate" placeholder="${getListInfoResp.custom_order_hopedate }" required>
				<br>
			<input class="input_req form-control btn btn-primary btn_send" type="submit" value="견적서 수정">
		</form>
	</div>
<!--       <div class="modal-footer"> -->
<!--         <button type="button" class="btn btn-secondary btn_return" data-dismiss="modal">취소</button> -->
<!--       </div> -->
    </div>
  </div>
</div>

</article>


<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>