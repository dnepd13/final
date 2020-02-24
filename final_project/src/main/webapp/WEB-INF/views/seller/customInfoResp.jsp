<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		var alarm = $(".btn_update").data("alarm_check");

		if(alarm=="N"){
			$(".btn_update").attr("disabled", false);
			$(".btn_update").click(function(){
				$(".update_form").show();
			});
		}
		
		$(".btn_return").click(function(){
			$(".update_form").hide();
		});

	});
</script>

<h3>Seller Custom Info Resp.jsp</h3>
	
<h4>보낸 견적서 상세내용</h4>
	<div>
	제목: ${getListInfoResp.custom_order_title } <br>
	상세내용 <br>
	${getListInfoResp.custom_order_content } <br>
	견적가격: ${getListInfoResp.custom_order_price } <br>
	가능날짜: ${getListInfoResp.custom_order_hopedate } <br>
	<c:if test="${ not empty filesVO }">
	첨부파일<br>
	<c:forEach var="filesVO" items="${filesVO }">
		<img src="http://localhost:8080/ordering/seller/download?files_no=${filesVO.files_no }" width=100px; height=100px;>
	</c:forEach>
	</c:if>
	<br>
	현재상태: ${getListInfoResp.custom_order_status }	
	
	<button class="btn_update" data-alarm_check="${alarm.member_alarm_check }" disabled>
		수정
	</button>
	<a href="${pageContext.request.contextPath }/seller/customListResp">목록으로</a>
	<hr>
	</div>
	
<div class="update_form" style="display:none">
	<form action="updateResp" method="post">
		<input type="hidden" name="category_no" value=${category_no }>
		<input type="hidden" name="custom_order_no" value="${getListInfoResp.custom_order_no }">
		<input type="hidden" name="seller_custom_order_no" value="${getListInfoResp.seller_custom_order_no }">
		<input type="text" name="custom_order_title" placeholder="${getListInfoResp.custom_order_title }" required>
		<h5>견적서의 상세내용을 작성해주세요.</h5>
		<textarea name="custom_order_content" placeholder="${getListInfoResp.custom_order_content }" required></textarea>
		<h5>희망 견적은 얼마인가요?</h5>
		<input type="number" name="custom_order_price" placeholder="${getListInfoResp.custom_order_price } 원">
		<h5>언제까지 가능한가요?</h5>
		<input type="date" name="custom_order_hopedate" placeholder="${getListInfoResp.custom_order_hopedate }" required>
		<br><br>
		<input type="submit" value="견적서 수정">
	</form>
	<button class="btn_return">취소</button>
</div>