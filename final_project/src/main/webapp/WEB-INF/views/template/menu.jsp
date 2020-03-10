<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

<style>
/*	부트스트랩 nav */
	.navbar {
	    padding: 3px 4rem;
	}

</style>

<nav class="navbar navbar-expand-md navbar-light" style="border-top: 1px solid #BFC9D9; border-bottom: 1px solid #BFC9D9;">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor03" style="padding: 0 2rem;">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/goods/search?keyword=" style="padding: 0 15px;">전체보기</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/goods/search?keyword=반지" style="padding: 0 15px;">반지</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/goods/search?keyword=목걸이" style="padding: 0 15px;">목걸이</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/goods/search?keyword=팔찌" style="padding: 0 15px;">팔찌</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0" action="${pageContext.request.contextPath}/goods/search" method="GET">
      <input class="form-control mr-sm-2" type="text" placeholder="Search" name="keyword">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>

<section class="wrap">