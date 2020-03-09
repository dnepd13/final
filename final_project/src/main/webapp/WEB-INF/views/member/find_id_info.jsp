<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

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
	<div class="row-empty-40"><br>
	    <form action="find_id_info" method="post">
			<h4 align="center">회원 아이디 : ${memberDto.member_id}</h4><br>
			<p align="right"><input type="submit" value="로그인하기" class="btn btn-secondary"></p> 
   		</form>
	</div>
</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>    
