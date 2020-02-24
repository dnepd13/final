<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>

<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
  
<script>
	function deleteReq(member_custom_order_no){

		if(confirm("요청서를 삭제하시겠습니까?")){
			$.ajax({
				url : "deleteReq",
				data: {"member_custom_order_no" : member_custom_order_no},
				method: "get",
				success: function(resp){
						location.reload(true);
					},
				error: function(error){
						alert("읽음 처리된 요청서는 삭제할 수 없습니다.");
					}
			})		
		}
		else{
			return false;
		}		
	}
	
	function deleteCateReq(member_custom_order_no){

		if(confirm("요청서를 삭제하시겠습니까?")){
			$.ajax({
				url : "deleteReq",
				data: {"member_custom_order_no" : member_custom_order_no},
				method: "get",
				success: function(resp){
						location.reload(true);
					},
				error: function(error){
						alert("요청서가 삭제되었습니다.");
					}
			})		
		}
		else{
			return false;
		}		
	}
</script>

<h3>구매자가 보낸 요청서. member customListReq.jsp</h3>

<a href="${pageContext.request.contextPath }">home</a> &#124; 

<h4>확인 안 한 견적서 몇 개냐: <span>${customAlarm } 개</span></h4>	

<c:forEach var="memberCustom" items="${getListReq }">
<div>
	cateNo: <span>${memberCustom.custom_order_category }</span><br>
	<a href="customInfoReq?member_custom_order_no=${memberCustom.member_custom_order_no }">
		제목: ${memberCustom.custom_order_title }</a>
			
	<c:choose> 
		<c:when test="${functions:length(memberCustom) == 1}">
			<button onclick="deleteReq(${memberCustom.member_custom_order_no })">&Cross;</button>
		</c:when>
		<c:otherwise>
			<button onclick="deleteCateReq(${memberCustom.member_custom_order_no })">&Cross;</button>
		</c:otherwise>
	</c:choose>
	<br>
	작성일: ${memberCustom.custom_order_date }
	<hr>
</div>
</c:forEach>

<!-- 내비게이터 -->
<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/customListReq?pageNo=${paging.startBlock-1}">&laquo;</a>
   			 </li>
		</c:if>
		<c:forEach begin="${paging.startBlock }" end="${paging.finishBlock }" var="p">
			<c:choose>
				<c:when test="${p == paging.pno }">
					<li class="page-item active">
   					   <a class="page-link" >${p }</a>
   					 </li>
				</c:when>
				<c:when test="${p != paging.pno }">
					<li class="page-item active">
      					<a class="page-link" href="${pageContext.request.contextPath}/member/customListReq?pageNo=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/customListReq?pageNo=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>	
</div>
