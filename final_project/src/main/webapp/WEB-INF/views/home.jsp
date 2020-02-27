<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">

<style>
	* {box-sizing: border-box;}
	.basic_color {
		color: rgb(248,245,240);
	}
	.row-empty {
   		height: 20px;
	}
	
/*	로그인 navbar 전체 style*/
	.nav_login * {
		list-style: none;
		margin: 0 0;
		box-sizing: border-box;
	}
	.nav_login .left_line {
		float: left;
		padding: 5px 20px;
	}
	.nav_login .right_line {
		float: right;
		padding: 5px 20px;
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
	
	.nav_login a:link { color: black; text-decoration: none;}
    .nav_login a:visited { color: black; text-decoration: none;}
    .nav_login a:hover { color: rgb(142,140,132); text-decoration: underline;}

/*	부트스트랩 nav */
	.navbar {
	    padding: 3px 1rem;
	}
	.navbar .nav-link {
		margin: 5px 0;
	    padding: 0 2rem;
	    border-left: 1px solid rgba(255,255,255,0.1);
	    border-right: 1px solid rgba(0,0,0,0.2);
	    font-size: 13px;
	}
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
				<li class=""><a href="#">판매자</a></li>
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
		<li class="right_line main_line"><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
	</ul>
	</c:otherwise>
</c:choose>

<!-- 회원 로그인 상태 -->
<div class="row-empty"></div>
<hr class="basic_color">
<div class="row-empty"></div>
<h1>홈</h1>
<div class="row-empty"></div>

<nav class="navbar navbar-expand-md navbar-light bg-light">
  <a class="navbar-brand" href="${pageContext.request.contextPath }">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor03">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="#">반지</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">목걸이</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">팔찌</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">etc.</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>

	<span><a href="${pageContext.request.contextPath }/goods/getList">상품List</a></span>
	<span>&verbar;</span>
	<span><a href="${pageContext.request.contextPath }/goods/insert">상품등록</a></span>
	<h1><a href="/ordering/board/memberreport">회원신고게시판</a></h1><br>
<!-- 바뀐 session의 member_no에서 memeber_id를 구해서 확인  -->

</body>
</html>
