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
		height: 800px;
		margin: 0 auto;
	}
	.req_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 900px;
	}
	.reqList {
		margin: 0 auto;
		width: 80%;
	}
	table {
		border: 1px solid gray;
	}
	
	.dataEmpty {
		height: 300px;
	}
	
	.close {
		float: right;
	}
</style>

<script src="https://code.jquery.com/jquery-latest.js"></script>
    
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
						alert("요청대기 상태의 요청서만 삭제할 수 있습니다.");
					}
			})		
		}
		else{
			return false;
		}		
	}

</script>

<article class="articleBox">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
<div class="req_wrap">
	<div class="reqList">
		<table class="table table-hover">
				<c:forEach var="memberCustom" items="${getListReq }">
					<tr>
						<td>
							<p><a href="customInfoReq?member_custom_order_no=${memberCustom.member_custom_order_no }">
								${memberCustom.custom_order_title }
								</a>
							</p>
							<p>
								<span>
									<fmt:parseDate value="${memberCustom.custom_order_date }" var="custom_order_date" pattern="yyyy-MM-dd HH:mm:ss"/>
									<fmt:formatDate value="${custom_order_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
								</span>
								<c:set var="check" value="${memberCustom.custom_order_status }"/>
								<c:choose>
									<c:when test="${functions : contains(check, '요청대기') }">
										<span aria-hidden="true"><button class="close" aria-label="Close" onclick="deleteReq(${memberCustom.member_custom_order_no })">&times;</button>요청대기</span>
									</c:when>
									<c:otherwise>
										<span class="close">${memberCustom.custom_order_status }</span>
									</c:otherwise>
								</c:choose>
								
							</p>
						</td>
					</tr>
				</c:forEach>
		</table>
	</div>
	<!-- 내비게이터 -->
	<div class="row justify-content-center">
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
</div>
</article>
<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>