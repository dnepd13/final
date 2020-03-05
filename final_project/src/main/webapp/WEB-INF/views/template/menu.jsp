<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

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

<section class="wrap">