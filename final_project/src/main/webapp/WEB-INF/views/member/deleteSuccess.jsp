<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 회원 탈퇴 성공 안내창 -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>


<style>
	.regist-area {
		width: 500px;
		margin: 0 auto;
		padding-top: 50px;
	}
	.btn_regist {
		width: 100%;'
	}

 	.card-body table td {
 		heigh: 150px;
 		padding: 10px 0;
 	}
</style>

<div class="row-empty-40"></div>
<div class="row-empty-40"></div>

<div class="regist-area card border-primary mb-3">
	<div class="" style="width:100%;" align="center">
	<h2>탈퇴처리되었습니다.<br> 그동안 이용해주셔서 감사합니다.</h2>
	</div>
	<div class="card-body" align="center">
	<span><a href="${pageContext.request.contextPath }/">메인으로</a></span>
	</div>
</div>






<jsp:include page="/WEB-INF/views/template/footer.jsp"/>