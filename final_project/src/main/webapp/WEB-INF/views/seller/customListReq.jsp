<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://code.jquery.com/jquery-latest.js"></script>
    
<script>

	//요청서 삭제
	function deleteReq(member_custom_order_no){
		if(confirm('요청서를 삭제하시겠습니까?')){
			$.ajax({
				url : "deleteReq",
				data : {"member_custom_order_no": member_custom_order_no},
				method: "GET",
				success: function(resp){
					location.reload(true);
				}
			});
			
	    }
	    else{
	    	return false;
		}
	}
			
    </script> 
    
<button class="toast"></button>

<h3>판매자가 받은 요청서 customListReq.jsp</h3>
<a href="main">판매자 홈으로</a> &verbar; 
<a href="customListResp">보낸 견적서</a>
<h4>확인 안 한 요청서 몇 개냐: <span class="alarm">${customAlarm } 개</span></h4>	

<h4>요청서 목록</h4>
<div>
<c:forEach var="memberReq" items="${getListReq }">
	<div>
		보낸사람: ${memberReq.member_id }
		<button onclick="deleteReq(${memberReq.member_custom_order_no })">&Cross;</button><br>
		제목: <a href="customInfoReq?member_custom_order_no=${memberReq.member_custom_order_no }">
						${memberReq.custom_order_title }
				</a>
				<span style="color: red">
				<c:set var="check" value="${memberReq.seller_alarm_check }"/> 
				<c:if test="${functions : contains(check, 'N') }"> new </c:if>
				</span>
		<br>	
		작성일: ${memberReq.custom_order_date } <br>
	<hr>
	</div> 
</c:forEach>
</div>

<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/seller/customListReq?pageNo=${paging.startBlock-1}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/seller/customListReq?pageNo=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/seller/customListReqt?pageNo=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>
</div>


