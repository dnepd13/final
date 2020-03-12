<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>

<style>
  /* 사이드바 래퍼 스타일 */
  
  #page-wrapper {
    padding-left: 250px;
  }
  
  #sidebar-wrapper {
    position: fixed;
    width: 250px;
    height: 100%;
    margin-left: -250px;
    background: #000;
    overflow-x: hidden;
    overflow-y: auto;
  }
  
  #page-content-wrapper {
    width: 100%;
    padding: 20px;
  }
  /* 사이드바 스타일 */
  
  .sidebar-nav {
    width: 250px;
    margin: 0;
    padding: 0;
    list-style: none;
  }
  
  .sidebar-nav li {
    text-indent: 1.5em;
    line-height: 2.8em;
  }
  
  .sidebar-nav li a {
    display: block;
    text-decoration: none;
    color: #999;
  }
  
  .sidebar-nav li a:hover {
    color: #fff;
    background: rgba(255, 255, 255, 0.2);
  }

	.sidebar-nav > .sidebar-home {
    font-size: 2em;
    line-height: 3em;
    
  }

</style>

<div id="page-wrapper">
  <!-- 사이드바 -->
  <div id="sidebar-wrapper">
    <ul class="sidebar-nav">
      <li class="sidebar-brand sidebar-home">
        <a href="${pageContext.request.contextPath}/home" class="navbar-brand" style="color:white;">ODERING</a>
      </li>
      <c:if test="${admin_grade == '총괄관리자' }">
			     <li class="nav-item"><a href="${pageContext.request.contextPath}/regist" class="nav-link" style="color:white;">관리자가입</a></li class="nav-item">
			     <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/manage" class="nav-link" style="color:white;">관리자관리</a></li>
	            <li class="nav-item"><a href="${pageContext.request.contextPath}/basicpagesetting" class="nav-link" style="color:white;">사이트 기본 정보 관리</a></li>
			</c:if>
			<c:if test="${admin_grade ==  '일반관리자'}">
				<li class="nav-item"><a href="${pageContext.request.contextPath}/admin/my" class="nav-link" style="color:white;">내정보</a></li>
			</c:if>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/seller/manage" class="nav-link" style="color:white;">판매자관리</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/member/manage" class="nav-link" style="color:white;">회원관리</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/gradebenefit" class="nav-link" style="color:white;">회원등급혜택</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/premium" class="nav-link" style="color:white;">수수료관리</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/board/manageqna" class="nav-link" style="color:white;">관리문의게시판</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/category" class="nav-link" style="color:white;">카테고리 관리</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/blocklist" class="nav-link" style="color:white;">차단된 회원 목록</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/goods/list" class="nav-link" style="color:white;">상품 목록</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/custom/list" class="nav-link" style="color:white;">주문제작</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/calculate/total" class="nav-link" style="color:white;">정산</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/logout" class="nav-link" style="color:white;">로그아웃</a></li>
    </ul>
  </div>
  <!-- /사이드바 -->
	
