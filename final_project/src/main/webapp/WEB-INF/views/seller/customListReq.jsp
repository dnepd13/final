<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>

<style>
	.articleBox {
		width: 1000px;
		height: 100%;
		margin: 0 auto;
	}
	.dataEmpty {
		height: 300px;
	}
	
	.delete {
		float: right;
	}
</style>

<script src="https://code.jquery.com/jquery-latest.js"></script>
    
<script>
	//요청서 삭제
	$(function(){
		
		$(".deleteReq").click(function(e){
			var status = $(this).parents("#req_data").data("custom_order_status");
			
			if(status=='결제완료' || status=='결제취소'){
				alert("결제완료 또는 결제취소된 요청서는 삭제할 수 없습니다.");
				return false;
			}
			else {
				if(confirm('요청서를 삭제하시겠습니까?')){
					return true;
				}
				else{
					return false;
				}
			}

		});
		
	});
			
</script> 



<article class="articleBox">

<h4>받은 요청서</h4>	
<table class="table table-hover listBox">
	<c:forEach var="memberReq" items="${getListReq }">
	<tr>
		<td id="req_data"
				data-custom_order_status="${memberReq.custom_order_status }">
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
			<span>
				<fmt:parseDate value="${memberReq.custom_order_date }" var="custom_order_date" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${custom_order_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
			</span>
			<c:set var="check" value="${memberReq.custom_order_status }"/>
				<c:choose>
					<c:when test="${functions : contains(check, '결제완료') }">
						<span aria-hidden="true" class="close">${memberReq.custom_order_status }</span>
					</c:when>
					<c:otherwise>
						<form action="deleteReq" method="get">
							<input type="hidden" name="member_no" value="${memberReq.member_no }">
							<input type="hidden" name="member_custom_order_no" value="${memberReq.member_custom_order_no }">
							<span aria-hidden="true">${memberReq.custom_order_status }<input type="submit" class="close deleteReq"aria-label="Close" value="&times;"></span>
						</form>
					</c:otherwise>
				</c:choose>
		</td>
	</tr>
	</c:forEach>

</table>

<div class="row justify-content-center">
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


<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>