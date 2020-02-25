<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈</title>
</head>
<body>
<main>
	<!-- 메인 내비 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#">Navbar</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

  <div class="collapse navbar-collapse" id="navbarColor03">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Features</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Pricing</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">About</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
	<section>
	</section>
</main>

<h1>홈</h1>



	<span><a href="${pageContext.request.contextPath }/seller/login">판매자로그인</a></span>
	<span> &#124; </span>
	<span><a href="${pageContext.request.contextPath }/goods/insert">상품등록</a></span>
<!-- 바뀐 session의 member_no에서 memeber_id를 구해서 확인  -->

<!-- 로그인 내용  -->
<c:choose>
	<c:when test="${member_id == null}">
		<form role="form" method="post" autocomplete="off" action="/member/login">
			<p><a href="/ordering/member/login">일반회원 로그인</a></p>
			<p><a href="/ordering/member/regist">회원가입</a></p>
		</form>
		<span><a href="${pageContext.request.contextPath }/goods/getList">상품List</a></span>
		<p><a href="/ordering/member/login">요청서 보내기</a>
	</c:when>

	<c:otherwise>
		<p>${member_id}님 환영합니다.</p>
    <h1><a href="/ordering/member/membermyinfo">마이페이지</a></h1>
		<h1><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></h1>
		
		<h1><a href="/ordering/board/memberreport">회원신고게시판</a></h1><br>
<h1><a href="/ordering/board/memberqna">회원문의게시판</a></h1><br>
		
		<span><a href="${pageContext.request.contextPath }/goods/getList">상품List</a></span>
		<span>&verbar;</span>
		<span><a href="${pageContext.request.contextPath }/member/customCate">요청서 보내기</a></span>
	</c:otherwise>
</c:choose>

</body>
</html>