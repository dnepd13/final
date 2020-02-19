<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
<script>
	function deleteResp(seller_custom_order_no){

		if(confirm("견적서를 삭제하시겠습니까?")){
			$.ajax({
				url : "deleteResp",
				data: {"seller_custom_order_no" : seller_custom_order_no},
				method: "get",
				success: function(resp){
					location.reload(true);
				},
				error: function(error){
					alert("읽음 처리된 견적서는 삭제할 수 없습니다.");
				}
			});
		}	
		else{
			return false;
		}
		
	}
</script>

<h3>판매자가 보낸 견적서 customListResp.jsp</h3>

<a href="main">판매자 홈으로</a> &verbar; 
<a href="customListReq">받은 요청서</a>
<h4>확인 안 한 요청서 몇 개냐: <span class="alarm">${customAlarm } 개</span></h4>	

<h4>보낸 견적서</h4>
<c:forEach var="sellerCustom" items="${getListResp }">
	<div>
	제목: <a href="customInfoResp?seller_custom_order_no=${sellerCustom.seller_custom_order_no }">
						${sellerCustom.custom_order_title }
			</a>
			<button onclick="deleteResp(${sellerCustom.seller_custom_order_no })">&Cross;</button>
			<br>	
	작성일: ${sellerCustom.custom_order_date } <br>
	<hr>
	</div>
</c:forEach>

<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/seller/customListResp?pageNo=${paging.startBlock-1}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/seller/customListResp?pageNo=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/seller/customListResp?pageNo=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>
</div>

