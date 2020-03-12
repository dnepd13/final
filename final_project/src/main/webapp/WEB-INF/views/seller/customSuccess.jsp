<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>

<style>
	.redirect-box {
		border: 1px solid #A6A6A6;
		width: 400px;
		height: 200px;
		margin-top: 10%;
		margin-left: 35%;
	}
	.redirect-content {
		padding: 50px;
	}
</style>

<div class="redirect-box row justify-content-center">

<div class="redirect-content">
	<h4 align="center">견적서를 전송하였습니다.</h4><br>
	<div class="row-empty-40"><br>
	<span><a href="${pageContext.request.contextPath }/seller/management">메인으로</a></span>
	 &verbar; 
	<span><a href="${pageContext.request.contextPath }/seller/customListResp">보낸 견적서 확인하기</a></span>
	</div>
</div>

</div>






<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>