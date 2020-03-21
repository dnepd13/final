<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 회원 탈퇴 실패 -->  

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	.myInfo_wrap {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
	}
	.addr_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 900px;
	}
	.addr_wrap::after{content:""; display: block; clear:both;}
	.addr_main {
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;
	}
	.addr_mainBox1 {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large; 
	}
	.addr_mainBox3 {
		width: 307px;
		height: 100%;
		padding-top: 35px;
		padding-left: 25px;
		margin-left: 500px;
		font-size: x-large; 
/* 		background: #F3F5F8; */
	}
	.addr_mainBox3 ::after {
		content="";
		display: block;
		clear: both;	
	}
	.addr_list {
		margin: 30px auto;
		width: 90%;
	}
	
	table thead {background: #F3F5F8; }
	table thead tr {
		border-top: 2px solid gray;
		text-align: center;
	}
	table tbody td{
		text-align: left;
	}
	
	.btn_area {
		margin: 0 auto;
		width: 90%;
	}
	
 /* modal 전체 스타일 */
 	.modal {
 		display: none;
 		z-index: 1;
 		top: 0;
 		bottom: 0;
 		letf: 0;
 		right: 0;
 		background-color: rgba(0,0,0,0.3);
 	}
 	
 /* modal 내부 컨텐츠 스타일 */
 	#sample6_postcode {
 		float: left;
 	}
 	.btn_findPost {
		position: relative;
		border-radius: 2px;
		margin-left: 10px;
		margin-top: 3px;
	}
	.btn_findPost::after {
		content: "";
		display: block;
		clear: both;
	}
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

<div class="myInfo_wrap">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
	<div class="addr_wrap">
		

			<div class="regist-area card border-primary mb-3">
			<h4 align="center">
			(입력하신 비밀번호가 잘못되었습니다)
			</h4><br>
			
			<div class="card-body" align="center">
			<span><a href="${pageContext.request.contextPath }/">메인으로</a></span>
			&verbar; 
			<span><a href="${pageContext.request.contextPath }/member/membermyinfo">마이 페이지로</a></span>
			</div>
			</div>
		
	</div>
</div>





<jsp:include page="/WEB-INF/views/template/footer.jsp"/>