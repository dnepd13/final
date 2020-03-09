<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<script src="https://code.jquery.com/jquery-latest.js"></script>
    
<script>
	$(function(){
		
		$(".delete_resp").click(function(e){

			var status = $(this).parents("#resp_data").data("custom_order_status");
			if(status=='결제완료' || status=='결제취소'){
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
		width: 1200px;
		height: 800px;
		margin: 0 auto;
	}
	.resp_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 900px;
	}
	.resp_main {
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;
	}
	.resp_mainBox1 {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large; 
	}
	.respList {
		margin: 30px auto;
		width: 80%;
	}
	table {
		border: 1px solid gray;
	}
	
	.dataEmpty {
		height: 300px;
	}
	
	.new {
		float: right;
	}
</style>

<article class="articleBox">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
<c:choose>
	<c:when test="${ empty getListResp }">
		<div class="resp_wrap">
			<div class="respList dataEmpty">
				<div class="row-empty-40"></div>
				<h5 align="center">받은 견적서가 없습니다.</h5><hr>
				<div class="row-empty-40"></div>
				<p>
					<small id="emailHelp" class="form-text text-muted">
						&check; "<span style="color: #52B1E0;">견적서</span>"는 개인 주문제작 "<span style="color: #52B1E0;">요청서</span>"에 대해 회신받은 문서입니다. <br>
						&nbsp;&nbsp;&nbsp;상품 상세페이지의 '<strong>1:1요청서</strong>' 또는 웹페이지 최상단의 '<strong>주문제작</strong>'을 통해 요청서를 보내시면 판매자가 이를 확인하고 견적서를 회신합니다.<br>
						&nbsp;&nbsp;&nbsp;원하는 상품이 없으시다면 판매자에게 주문제작을 의뢰해보는건 어떠신가요?
					</small>
				</p>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<div class="resp_wrap">
			<div class="resp_main">
				<div class="resp_mainBox1">
					받은 견적서 관리
				</div>
			</div>
			<div class="respList">
				<table class="table table-hover">
				
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
			</div>
			
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
		</div>
	</c:otherwise>
</c:choose>
</article>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>