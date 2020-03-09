<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	.articleBox,
	.navBox {
		width: 500px;
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
$(function(){
	
	$(".delete_resp").click(function(e){
		var status = $(this).parents("#resp_data").data("custom_order_status");

		if(confirm('견적서를 삭제하시겠습니까')){
			if(status=='견적대기'){
				return true;
			}
			else {
				alert("견적대기 상태의 견적서만 삭제할 수 있습니다.");
			}
		}
		else{
			return false;
		}
	});

});
</script>

<h3>판매자가 보낸 견적서 customListResp.jsp</h3>

<h4>확인 안 한 요청서 몇 개냐: <span class="badge badge-pill badge-info">${customAlarm}</span></h4>	

<article class="articleBox">
<table class="table table-hover listBox">
<c:choose>
	<c:when test="${ empty getListResp }">
		<tr class="dataEmpty">
			<td>
				<div class="row-empty-40"></div><div class="row-empty-40"></div>
				<div align="center" style="padding: 10px;">
					보낸 견적서가 없습니다.
				</div><div class="row-empty-40"></div><div class="row-empty-40"></div><div class="row-empty-40"></div>
			</td>
		</tr>
	</c:when>
	<c:otherwise>
	<c:forEach var="sellerCustom" items="${getListResp }">
		<tr>
			<td id="resp_data"
					data-seller_custom_order_no="${sellerCustom.seller_custom_order_no }"
					data-custom_order_status="${sellerCustom.custom_order_status }"
					data-member_no="${sellerCustom.seller_no }">
				<p>
					<a href="customInfoResp?seller_custom_order_no=${sellerCustom.seller_custom_order_no }">
							${sellerCustom.custom_order_title }
					</a>
				</p>
				<p>
					<span>
						<fmt:parseDate value="${sellerCustom.custom_order_date }" var="custom_order_date" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${custom_order_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
					</span>
					<c:set var="check" value="${sellerCustom.custom_order_status }"/>
						<c:choose>
							<c:when test="${functions : contains(check, '견적대기') }">
								<form action="deleteResp" method="get">
									<input type="hidden" name="seller_no" value="${sellerCustom.seller_no }">
									<input type="hidden" name="seller_custom_order_no" value="${sellerCustom.seller_custom_order_no }">
									<span aria-hidden="true">${sellerCustom.custom_order_status }<input type="submit" class="close delete_resp"aria-label="Close" value="&times;"></span>
								</form>
							</c:when>
							<c:otherwise>
								<span class="close">${sellerCustom.custom_order_status }</span>
							</c:otherwise>
						</c:choose>
				</p>
			</td>
		</tr>
	</c:forEach>
	</c:otherwise>
</c:choose>
</table>

<div class="row justify-content-center">
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
</article>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>