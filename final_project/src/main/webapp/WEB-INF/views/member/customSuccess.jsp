<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	.box {
		padding-top: 100px;
		margin-left: 500px;
	}
	.redirect-box {
		border: 1px solid #A6A6A6;
		width: 400px;
		height: 200px;
	}
	.redirect-content {
		padding: 50px;
	}
</style>

<div class="box">
	<div class="redirect-box row justify-content-center">
	
	<div class="redirect-content">
		<h4 align="center">요청이 완료되었습니다.</h4><br>
		<div class="row-empty-40"><br>
		<span><a href="${pageContext.request.contextPath }">메인으로</a></span>
		 &verbar; 
		<span><a href="${pageContext.request.contextPath }/member/customListReq">보낸 요청서 확인하기</a></span>
		</div>
	</div>
	
	</div>
</div>





<jsp:include page="/WEB-INF/views/template/footer.jsp"/>