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

<style>
	.articleBox {
		width: 1000px;
		margin-left: 300px;
		padding-top: 5rem;
	}
	@media screen and (min-width:1360px){
		.articleBox {
			width: 60%;
			margin: 0 auto;
		}
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
	
	function deleteCustom(member_custom_order_no){

		if(confirm("요청서를 삭제하시겠습니까?")){
			$.ajax({
				url : "deleteCustom",
				data: {"member_custom_order_no" : member_custom_order_no},
				method: "get",
				success: function(resp){
						alert("요청서가 삭제되었습니다.");
						location.reload(true);
					},
			})		
		}
		else{
			return false;
		}		
	}
</script>

<article class="articleBox infoPage-area">
<table class="table table-hover listBox">
<c:choose>
	<c:when test="${ empty getListReq }">
		<tr class="dataEmpty">
			<td>
				<div class="row-empty-40"></div><div class="row-empty-40"></div>
				<div align="center" style="padding: 10px;">
					보낸 요청서가 없습니다.
				</div><div class="row-empty-40"></div><div class="row-empty-40"></div><div class="row-empty-40"></div>
				<p align="right"><a href="${pageContext.request.contextPath }/member/customCate"><button class="btn_custom">요청서 보내기</button></a></p>
			</td>
		</tr>
	</c:when>
	<c:otherwise>
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
						<span aria-hidden="true"><button class="close" aria-label="Close" onclick="deleteReq(${memberCustom.member_custom_order_no })">&times;</button></span>
					</p>
				</td>
			</tr>
		</c:forEach>
	</c:otherwise>
</c:choose>
</table>

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
</article>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>