<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 회원 탈퇴 실패 안내창 -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>


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
	

	.redirect-box {
		border: 1px solid #A6A6A6;
		width: 400px;
		height: 200px;
		margin-top: 10%;
		margin-left: 35%;
		text-align: center;
	}
	.redirect-content {
		padding: 50px;
	}
</style>


<div class="myInfo_wrap">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
	<div class="main_wrap">
				
<div class="row justify-content-center">		
<div class="redirect-box row justify-content-center" align="center">

<div class="redirect-content">

	<h4 align="center">
	(입력하신 비밀번호가 잘못되었습니다)
	</h4><br><br>
	<div class="row-empty-40"><br>
	<span><a href="${pageContext.request.contextPath }/">메인으로</a></span>
	 &verbar; 
	<span><a href="${pageContext.request.contextPath }/member/membermyinfo">마이 페이지로</a></span>
	</div>
</div>


</div>

</div>
</div>
</div>






<jsp:include page="/WEB-INF/views/template/footer.jsp"/>