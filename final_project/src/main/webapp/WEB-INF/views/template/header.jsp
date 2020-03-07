<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>order-링</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

<style>
	* {box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-moz-box-sizing: border-box;}
	html,
	body{
		margin: 0;
		height: 100%;
	}
	.wrap {
		min-height: 100%;
		position: relative;
		padding-bottom: 150px;
	}
	
	.basic_color {
		color: rgb(248,245,240);
	}
	.row-empty-20 {
   		height: 20px;
	}
	
/*	로그인 navbar 전체 style*/
	.nav_login * {
		list-style: none;
		margin: 0 0;
		box-sizing: border-box;
		overflow: hidden;
	}
	.nav_login .left_line {
		float: left;
		padding: 5px 20px;
	}
	.nav_login .right_line {
		float: right;
		padding: 5px 20px;
	}
	@media screen and (max-width:720px){
		.nav_login .left_line {
			display: none;
		}
	}
	/* 로그인 nav 서브메뉴 스타일 */
	.nav_login .sub_line {
		padding: 0 ;
		display: none; /* 평소에는 안 보이게 */
		box-shadow: 0px 0px 3px 0px darkgray;
		background-color: white;
		width: 100px;
		margin-top: 5px;
		position: absolute;
	}
	.nav_login .main_line:hover .sub_line {
		display: block;
		overflow: visible;
	} 
	.nav_login ::after {
		content: "";
		display: block;
		clear: both;
	}
	
	/* 로고이미지 */
	.logo-area {
		margin: 20px 0;
	}
	
	.nav_login a:link { color: black; text-decoration: none;}
    .nav_login a:visited { color: black; text-decoration: none;}
    .nav_login a:hover { color: rgb(142,140,132); text-decoration: underline;}

</style>

</head>
<body>

<!-- 일반회원 home -->
<c:choose>
	<c:when test="${member_id == null}">
	<ul class="nav_login">
		<li class="left_line main_line"><a href="">공지사항</a></li>
		<li class="left_line main_line"><a href="${pageContext.request.contextPath }/member/login">문의하기</a></li>
		<li class="right_line main_line" style="margin-right:50px;"><a href="${pageContext.request.contextPath }/member/login">주문제작</a></li>
		<li class="right_line main_line">회원가입
			<ul class="sub_line" style="border: 1px solid lightgray;">
				<li class=""><a href="${pageContext.request.contextPath }/member/regist">일반회원</a></li>
				<li class=""><a href="${pageContext.request.contextPath }/seller/regist">판매자</a></li>
			</ul>
		</li>
		<li class="right_line main_line">로그인
			<ul class="sub_line" style="border: 1px solid lightgray;">
				<li class=""><a href="${pageContext.request.contextPath }/member/login">일반회원</a></li>
				<li class=""><a href="${pageContext.request.contextPath }/seller/login">판매자</a></li>
			</ul>
		</li>
	</ul>
	</c:when>
	
	<c:otherwise>
	<ul class="nav_login">
		<li class="left_line main_line"><a href="#">공지사항</a></li>
		<li class="left_line main_line"><a href="${pageContext.request.contextPath }/board/memberqna">문의하기</a></li>
		<li class="right_line main_line" style="margin-right:50px;"><a href="${pageContext.request.contextPath }/member/customCate">주문제작</a></li>
		<li class="right_line main_line"><a href="${pageContext.request.contextPath }/member/membermyinfo">마이페이지</a></li>
		<li class="right_line main_line"><a href="${pageContext.request.contextPath }/member/cart">장바구니</a></li>
		<li class="right_line main_line"><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
	</ul>
	</c:otherwise>
</c:choose>

<div class="row-empty-20"></div>
<hr class="basic_color">

<div class="logo-area" align="center">
	<a class="" href="${pageContext.request.contextPath }">
  		<img src="${pageContext.request.contextPath}/resources/img/logo-ordering.png" style="width:auto; height: 100px;'">
  	</a>
</div>
