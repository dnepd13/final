<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    
 <h4>보낸 요청서 상세내용 member Custom Info Req.jsp</h4>
 	카테고리: ${category.category_large } / ${category.category_middle } / ${category.category_small } <br>   
	제목: <span>${getListInfoReq.custom_order_title}</span> <br>
	상세내용 <br>
			<span>${getListInfoReq.custom_order_content}</span> <br>
	희망가격:
			<span>${getListInfoReq.custom_order_price} </span><br>
	희망날짜: 
			<span>${getListInfoReq.custom_order_hopedate} </span><br>
	<c:if test="${ not empty filesVO }">
	첨부파일<br>
		<c:forEach var="filesVO" items="${filesVO }">
			<img src="http://localhost:8080/ordering/member/download?files_no=${filesVO.files_no}" width=100px; height=100px;>
		</c:forEach>
	</c:if>
	<br>
	현재상태: <span>${getListInfoReq.custom_order_status }</span>

	<button class="btn_update" data-alarm_check="${alarm.seller_alarm_check}" disabled>
		수정
	</button>
	<a href="${pageContext.request.contextPath }/member/customListReq">목록으로</a>
<hr>

<div class="update_form" style="display:none;">
	<form action="updateReq" method="post">
		<input type="hidden">
		<input type="hidden" name="custom_order_no" value="${getListInfoReq.custom_order_no}">
		<input type="hidden" name="member_custom_order_no" value="${getListInfoReq.member_custom_order_no}">
		<h5>요청서 제목을 작성해주세요.</h5>
		<input type="text" name="custom_order_title" placeholder="${getListInfoReq.custom_order_title}" required>
		<h5>요청하는 상세내용을 작성해주세요.</h5>
		<textarea name="custom_order_content" placeholder="${getListInfoReq.custom_order_content}" required></textarea>
		<h5>희망 가격은 얼마인가요?</h5>
		<input type="number" name="custom_order_price" placeholder="${getListInfoReq.custom_order_price}" required>
		<h5>희망 날짜는 언제인가요? </h5>
		<input type="date" name="custom_order_hopedate" placeholder="${getListInfoReq.custom_order_hopedate}" required>
		<br><br>
		<input type="submit" value="요청서 수정">	
	</form>
	<button class="btn_return">취소</button>
</div>