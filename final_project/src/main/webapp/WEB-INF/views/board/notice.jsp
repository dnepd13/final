<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
.ordering_area {
	margin: 30px 0px;
}
.cart_table {
	border-top: 2px solid #171717;
	border-bottom: 1px solid #171717;
}
.col-lg-8 {
	margin: 25px 0px;
}
.cart_table_title {
	border-bottom: 1px solid #171717;
}
.items_area {
	border-bottom: 1px solid #171717;
}
.cart_area {
	margin: 15px 0px;
}
.section1{
	margin: 0 auto;
	width: 1500px;
}
 	/* a태그 하이퍼링크 표시 제어 */
    .notice_title a:link { text-decoration: none;}
    .notice_title a:visited { text-decoration: none;}
    .notice_title a:hover { text-decoration: none;}
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
			<h3>Notice</h3>
		</div>
		<table class="table table-borderless cart_table">
			<tr class="cart_table_title">
			
				<th scope="col" class="align-middle text-center" style="width: 800px">제목</th>
				<th scope="col" class="align-middle text-center" style="width: 150px">작성자</th>
				<th scope="col" class="align-middle text-center" style="width: 150px">구분</th>
				<th scope="col" class="align-middle text-center" style="width: 300px">작성시간</th>
			</tr>
			<c:forEach var="getNotice" items="${getNotice}">
			<tr class="items_area" align="center">
				<td align="left" style="padding-left: 20px;" class="notice_title">
						<a href="${pageContext.request.contextPath}/board/noticeDetails?admin_qna_no=${getNotice.admin_qna_no}">
							${getNotice.admin_qna_title }
						</a>	
				</td>
				<td>${getNotice.admin_qna_writer}</td>
				<td>${getNotice.admin_qna_usertype}</td>
				<td>
					<fmt:parseDate value="${getNotice.admin_qna_date}" var="admin_qna_date" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${admin_qna_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</table>
	</div>
</div>
</section>

<!-- 내비게이터 -->
		<div class="row justify-content-center">
			<ul class="pagination">
				<c:if test="${paging.startBlock > 1 }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/board/notice?pageNo=${paging.startBlock-1}">&laquo;</a>
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
		      					<a class="page-link" href="${pageContext.request.contextPath}/board/notice?pageNo=${p}">${p }</a>
		   					 </li>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.finishBlock < paging.pagecount}">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/board/notice?pageNo=${paging.finishBlock+1}">&raquo;</a>
		    		</li>
				</c:if>
			</ul>	
		</div>
		<!-- 내비게이터 영역 끝 -->	

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>