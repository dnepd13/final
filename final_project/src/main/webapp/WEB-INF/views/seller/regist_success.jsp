<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

<!-- 회원가입 완료창 -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

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
	<h4 align="center">회원가입이 완료되었습니다.</h4><br>
	<div class="row-empty-40"><br>
	<span><a href="${pageContext.request.contextPath }/">메인으로</a></span>
	 &verbar; 
	<span><a href="${pageContext.request.contextPath }/seller/login">로그인</a></span>
	</div>
</div>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"/>