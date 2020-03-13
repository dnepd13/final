<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
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

<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>


<div class="redirect-box row justify-content-center">

<div class="redirect-content">
	<h4 align="center">탈퇴처리되었습니다. 그동안 이용해주셔서 감사합니다.</h4><br>
	<div class="row-empty-40"><br>
	<span><a href="${pageContext.request.contextPath }/seller/main">메인으로</a></span>
	</div>
</div>

</div>






<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>