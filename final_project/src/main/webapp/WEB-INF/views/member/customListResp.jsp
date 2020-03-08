<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<script src="https://code.jquery.com/jquery-latest.js"></script>
    
<script>
	$(function(){
		
		$(".delete_resp").click(function(e){

			var status = $(this).parents("#resp_data").data("custom_order_status");
			if(status=='결제완료'){
				alert("결제완료된 견적서는 삭제할 수 없습니다.");
				return false;
			}
			else{
				if(confirm('견적서를 삭제하시겠습니까?')){
					return true;
				}
				else{
					return false;
				}
			}
		});
	
	});
</script>

<style>
	.articleBox {
		width: 1000px;
		height: 800px;
		margin-left: 300px;
		padding-top: 5rem;
	}
	
	.dataEmpty {
		height: 300px;
	}
	
	.new {
		float: right;
	}
</style>

<article class="articleBox infoPage-area">
<table class="table table-hover listBox">

		<c:forEach var="sellerResp" items="${getListResp }">
			<tr>
				<td id ="resp_data"
						data-seller_custom_order_no="${sellerResp.seller_custom_order_no }"
						data-custom_order_status="${sellerResp.custom_order_status }"
						data-member_no="${sellerResp.member_no }">
					<p><span>${sellerResp.seller_id } 님이 보낸 견적서입니다.</span>
						<span class="new" style="color: red">
							<c:set var="check" value="${sellerResp.member_alarm_check }"/>
							<c:if test="${functions : contains(check, 'N') }">
								new
							</c:if>
						</span>
					</p>
					<p><a href="customInfoResp?seller_custom_order_no=${sellerResp.seller_custom_order_no }">
								${sellerResp.custom_order_title }</a>
					</p>
					<span>
						<fmt:parseDate value="${sellerResp.custom_order_date }" var="custom_order_date" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${custom_order_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
					</span>
					<c:set var="check" value="${sellerResp.custom_order_status }"/>
						<c:choose>
							<c:when test="${functions : contains(check, '결제완료') }">
								<span aria-hidden="true" class="close">${sellerResp.custom_order_status }</span>
							</c:when>
							<c:otherwise>
								<form action="deleteResp" method="get">
									<input type="hidden" name="member_no" value="${sellerResp.member_no }">
									<input type="hidden" name="seller_custom_order_no" value="${sellerResp.seller_custom_order_no }">
									<span aria-hidden="true">${sellerResp.custom_order_status }<input type="submit" class="close delete_resp"aria-label="Close" value="&times;"></span>
								</form>
							</c:otherwise>
						</c:choose>
				</td>
		</c:forEach>

</table>

<!-- 내비게이터 -->
<div class="row justify-content-center">
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/customListResp?pageNo=${paging.startBlock-1}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/member/customListResp?pageNo=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/member/customListResp?pageNo=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>	
</div>
</article>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>