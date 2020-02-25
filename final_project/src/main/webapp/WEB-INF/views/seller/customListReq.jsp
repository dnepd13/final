<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 

<style>
	.articleBox,
	.navBox {
		width: 500px;
		margin: 0 auto;
	}
	.delete {
		float: right;
	}
</style>

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

<h3>판매자가 받은 요청서 customListReq.jsp</h3>

<h4>확인 안 한 요청서 몇 개냐: <span class="badge badge-pill badge-info">${customAlarm}</span></h4>	

<article class="articleBox">
<table class="table table-hover listBox">
	<c:forEach var="memberReq" items="${getListReq }">
	<tr>
		<td>
			<p><span>${memberReq.member_id } 님이 보낸 요청서입니다.</span>
				<span style="color: red">
					<c:set var="check" value="${memberReq.seller_alarm_check }"/> 
					<c:if test="${functions : contains(check, 'N') }">
						new
					</c:if>
				</span>
			</p>
			<p><a href="customInfoReq?member_custom_order_no=${memberReq.member_custom_order_no }">
						${memberReq.custom_order_title }</a>
			</p>
			<span>${memberReq.custom_order_date }</span>
			<span aria-hidden="true"><button class="close" aria-label="Close" onclick="deleteReq(${memberReq.member_custom_order_no })">&times;</button></span>
		</td>
	</tr>
	</c:forEach>
</table>

<div class="navBox">
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
</article>

