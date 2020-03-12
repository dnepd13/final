<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>

</style>


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
/* .cart_table_title { */
/* 	border-bottom: 1px solid #171717; */
/* } */
.items_area {
	border-bottom: 1px solid #171717;
}
.cart_area {
	margin: 15px 0px;
	height: 80%;
}
.section1{
	margin: 0 auto;
	width: 1500px;
}
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
		<div class="btn-group-vertical" style="float:right;">
			<a href="${pageContext.request.contextPath}/board/notice">
				목록으로
			</a>
		</div>
		<table class="table table-borderless cart_table">
			<tr class="cart_table_title">
				<th scope="col" class="align-middle text-center" style="width: 800px"></th>
				<th scope="col" class="align-middle text-center" style="width: 150px"></th>
				<th scope="col" class="align-middle text-center" style="width: 150px"></th>
				<th scope="col" class="align-middle text-center" style="width: 300px"></th>
			</tr>
			<tr class="items_area">
				<td colspan="4" align="left">
					<div style="height: 500px; margin: 0 50px;">
						<h5>${notice.admin_qna_title }</h5>
						<p align="right" style="margin:0;">${notice.admin_qna_writer }
							<small style="margin-left: 15px;">
								<fmt:parseDate value="${notice.admin_qna_date}" var="admin_qna_date" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:formatDate value="${admin_qna_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
							</small>
						</p>
						<div style="height:90%; background:#FAFAFA; padding:10px;">
							${notice.admin_qna_content }
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>
</section>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>    
