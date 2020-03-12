<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
 
 <style>
 	.articleBox {
 		width: 1200px;
		height: 1000px;
		margin: 0 auto;
	}
	.req_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 900px;
	}
	.req_main {
		margin: 0 auto;
		width: 60%;
		height: 50px;
	}

/*수정 modal 내부 input 스타일 */	
 	.insert_req  {
 		width: 90%;
 		margin: 0 auto;
 		padding-top: 50px;
 	}
 	.insert_req * {
 		width: 100%;
 	}
 	.text-primary {
 		font-weight: bold; 
 	}
 	.insert_req textarea{
 		resize: none;
 		height: 300px;
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
 	
 /*수정 modal 전체 스타일 */
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
<script>
	$(function(){
	// 수정 modal 제어
		var btn_update = document.querySelector(".btn_update");
		var modal = document.querySelector(".modal");
		var close = document.querySelector(".close");
		
		var alarm = $(".btn_update").data("alarm_check");

		// 알람 데이터가 null이 아니면 == 1:1 요청서인 경우 N이면 버튼 활성화
		// 자바스크립트에서는 다음 값들이 모두 부정적인 값으로 사용됨(논리식에서)
		// - null, undefined, 0, "", false
		if(alarm){		
			if(alarm=="N"){
				$(".btn_update").prop("disabled", false);
				// 수정 modal
				$(".btn_update").click(function(){
					modal.style.display = "block";
				});
				$(close).click(function(){
					modal.style.display = "none";
				});	
			}
			else if (alarm=="Y"){
				$("btn_update").prop("disabled", true);
				btn_update.style.color = "#BDBDBD";
			}
			
		}
		else {
			$(".btn_update").prop("disabled", false);
			// 수정 modal
			$(".btn_update").click(function(){
				modal.style.display = "block";
			});
			$(close).click(function(){
				modal.style.display = "none";
			});	
		}
		
		// 달력
// 		$(".date").datepicker({ 
// 			minDate: 0,
// 			dateFormat: "yy/mm/dd"
// 		});
		
		// 가격 입력제한
		$(".price").keyup(function(){

			if($(this).val()<=0 || $(this).val()>1000000){
				$(this).val("");
				alert("희망가격은 1원 이상, 100만원 이하로 작성해주세요.");
			}
		});

			// modal 바깥의 윈도우 클릭 시 modal 닫음		
// 		window.onclick = function(event){
// 			if(event.target == modal){
// 				modal.style.display = "none";
// 			}
// 		}
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
		// 날짜입력 길이 제한
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
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
<div class="req_wrap">
	<div class="req_main">
		<div class="card mb-3">
			<div class="card-header">
				<h5>${getListInfoReq.custom_order_title}</h5>
				<h6 class="card-subtitle text-muted">
					<span>
						<c:choose>
					 		<c:when test="${not empty category }">
							 	카테고리: ${category.category_large } / ${category.category_middle } / ${category.category_small } 
					 		</c:when>
					 		<c:otherwise>
					 			<c:choose>
					 				<c:when test="${ not empty seller_id }">
					 					${seller_id } 님에게 보낸 요청서
					 				</c:when>
					 				<c:otherwise>
					 					탈퇴한 판매자입니다.
					 				</c:otherwise>
					 			</c:choose>
					 		</c:otherwise>
				 		</c:choose>
					</span>
					<span style="float:right;">
						<fmt:parseDate value="${getListInfoReq.custom_order_date}" var="custom_order_date" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${custom_order_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
					</span><br>
					<span style="float:right;">${getListInfoReq.custom_order_status }</span>
				</h6>
			</div>
			<div class="card-body cart-text">
				<p>${getListInfoReq.custom_order_content}</p>
				<hr>
			</div>
			<c:if test="${ not empty filesVO }">
				<div align="center">
					<c:forEach var="filesVO" items="${filesVO }">
						<img src="http://localhost:8080/ordering/member/download?files_no=${filesVO.files_no}" width=50%; height=auto;>
					</c:forEach>
				</div>
				<hr>
			</c:if>
			<ul class="list-group list-group-flush">
				<li class="list-group-item card-text">
					<h6 class="card-subtitle text-muted">희망가격&Tab;</h6>
						<fmt:formatNumber pattern="###,###,###" type="number">
							${getListInfoReq.custom_order_price}
						</fmt:formatNumber> 원
					</li>
				<li class="list-group-item card-text">
					<h6 class="card-subtitle text-muted">희망날짜&Tab;</h6>
					${getListInfoReq.custom_order_hopedate}
					</li>
			</ul>
			<div class="card-footer text-muted content_last" align="right">
				<button class="btn_update" data-alarm_check="${alarm.seller_alarm_check}">
					수정
				</button>
				<a href="${pageContext.request.contextPath }/member/customListReq">목록으로</a>		
			</div>
		</div>
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
		<form action="updateReq" method="post">
			<input type="hidden" name="custom_order_no" value="${getListInfoReq.custom_order_no}">
			<input type="hidden" name="member_custom_order_no" value="${getListInfoReq.member_custom_order_no}">
			
			<h6 class="text-secondary">요청서 제목을 작성해주세요. (30자 이내)</h6>
			<input class="input_req form-control custom_order_title" type="text" name="custom_order_title" placeholder="${getListInfoReq.custom_order_title}" required>
				<br>
			<h6 class="text-secondary">요청하는 상세내용을 작성해주세요.</h6>
			<textarea class="input_req form-control custom_order_content" name="custom_order_content" placeholder="${getListInfoReq.custom_order_content}" required></textarea>
			<p align="right">(<span class="text_limit"></span> / 1000)</p>
			<h6 class="text-secondary">희망 가격은 얼마인가요?</h6>
			<input class="input_req form-control price" type="number" name="custom_order_price" placeholder="${getListInfoReq.custom_order_price} 원" required>
				<br>
			<h6 class="text-secondary">희망 날짜는 언제인가요? </h6>
			<input class="input_req form-control date" type="date" name="custom_order_hopedate" placeholder="${getListInfoReq.custom_order_hopedate}" required>
			<br>
			<input class="input_req form-control btn btn-primary btn_send"  type="submit" value="요청서 수정">
		</form>
	</div>
    </div>
  </div>
</div>

</article>

<div class="row-empty-40"></div> 

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>