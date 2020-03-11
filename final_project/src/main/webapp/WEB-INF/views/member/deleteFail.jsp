<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



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
	<h4 align="center">
	(입력하신 비밀번호가 잘못되었습니다)
	</h4><br><br>
	<h4>나는 아직 당신과 헤어지는 법을 몰라요. 우리 좀더 함께 해요.</h4>
	<div class="row-empty-40"><br>
	<span><a href="${pageContext.request.contextPath }/">메인으로</a></span>
	 &verbar; 
	<span><a href="${pageContext.request.contextPath }/member/membermyinfo">마이 페이지로</a></span>
	</div>
</div>

</div>






<jsp:include page="/WEB-INF/views/template/footer.jsp"/>