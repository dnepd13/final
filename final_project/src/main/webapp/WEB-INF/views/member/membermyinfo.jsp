<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<!-- 회원 마이페이지 -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	.myInfo_wrap {
		width: 1200px;
		height: 1000px;
		margin: 0 auto;
	}
	.main_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 900px;
	}
	.main_wrap::after{content:""; display: block; clear:both;}
	.main_title1,
	.main_title2 {
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;
	}
	.title1
	.title2 {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large;
	}
	.content_1
	.content_2 {
		margin: 30px auto;
		width: 90%;
	}
	table thead {background: #F3F5F8; }
	table thead tr {
		border-top: 2px solid gray;
		text-align: center;
	}
	table tbody tr{
		text-align: center;
	}
	
</style>

<div class="myInfo_wrap">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
	<div class="main_wrap">
				
		<div class="main_title1">
			<div class="title1">
				최근 나의 구매내역
			</div>
		</div>
		<div class="main_content1">
			<table class="table">
				<thead>
					<tr>
			      		<th scope="col">주문번호</th>
			      		<th scope="col">주문상품</th>
			      		<th scope="col">결제금액</th>
			      		<th scope="col">현재상태</th>
			      		<th scope="col">일자</th>
			    	</tr>
				</thead>
				<tbody>
				<c:forEach var="cartYesterDay" items="${cartYeseterDay}">
				    <tr>
							<td scope="row">${cartYesterDay.partner_order_id }</td>
							<td scope="row" align="left">${cartYesterDay.item_name }</td>
							<td scope="row" align="right">${cartYesterDay.total_price }</td>
							<td scope="row" align="center">${cartYesterDay.cart_info_status }</td>
						<td scope="row">
							<fmt:parseDate value="${cartYesterDay.process_time}" var="cart_date" pattern="yyyy-MM-dd HH:mm:ss"/>
							<fmt:formatDate value="${cart_date}" pattern="yyyy/MM/dd HH:mm:ss"/>
						</td>
					</tr>
				</c:forEach>
			  </tbody>
			</table>
		</div>
	</div>

	
	<!-- 최근 3일 관리자 문의 -->
	<div class="main_wrap">
		<div class="main_title2">
			<div class="title2">
				최근 나의 문의내역
			</div>
		</div>
		<div class="main_content2">
			<table class="table">
				<thead>
					<tr>
			      		<th scope="col">구분</th>
			      		<th scope="col">제목</th>
			      		<th scope="col">시간</th>
			    	</tr>
				</thead>
				<tbody>
				<c:forEach var="qna" items="${getListYesterDay}">
				    <tr>
						<c:choose>
							<c:when test="${qna.admin_qna_head=='답변' }">
								<td scope="row"></td>
								<td scope="row" align="left">[${qna.admin_qna_head}] ${qna.admin_qna_title}</td>
							</c:when>
							<c:otherwise>
								<td scope="row">${qna.admin_qna_head}</td>
								<td scope="row" align="left">${qna.admin_qna_title}</td>
							</c:otherwise>
						</c:choose>
						<td scope="row">
							<fmt:parseDate value="${qna.admin_qna_date}" var="qna_date" pattern="yyyy-MM-dd HH:mm:ss"/>
							<fmt:formatDate value="${qna_date}" pattern="yyyy/MM/dd HH:mm:ss"/>
						</td>
					</tr>
				</c:forEach>
			  </tbody>
			</table>
		</div>
		<!-- 문의 내비게이터 -->
			<div class="row justify-content-center">
				<ul class="pagination">
					<c:if test="${paging.startBlock > 1 }">
						<li class="page-item">
			     			 <a class="page-link" href="${pageContext.request.contextPath}/member/membermyinfo?pageNo=${paging.startBlock-1}">&laquo;</a>
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
			      					<a class="page-link" href="${pageContext.request.contextPath}/member/membermyinfo?pageNo=${p}">${p }</a>
			   					 </li>
							</c:when>
						</c:choose>
					</c:forEach>
					<c:if test="${paging.finishBlock < paging.pagecount}">
						<li class="page-item">
			     			 <a class="page-link" href="${pageContext.request.contextPath}/member/membermyinfo?pageNo=${paging.finishBlock+1}">&raquo;</a>
			    		</li>
					</c:if>
				</ul>	
			</div>
			<!-- 문의 내비게이터 끝 -->			
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>