<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
	
      <!--네비게이션 메뉴-->
      <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
          <!--대표 브랜드 로고-->
        <a href="${pageContext.request.contextPath}/home" class="navbar-brand">ODERING</a>
        <!--접이식 버튼-->
        <button class="navbar-toggler" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!--실제 메뉴-->
        <div class="collapse navbar-collapse">
          <ul class="navbar-nav">
            <c:if test="${admin_grade == '총괄관리자' }">
			     <li class="nav-item"><a href="${pageContext.request.contextPath}/regist" class="nav-link">관리자가입</a></li class="nav-item">
			     <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/manage" class="nav-link">관리자관리</a></li>
			</c:if>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/seller/manage" class="nav-link">판매자관리</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/member/manage" class="nav-link">회원관리</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/gradebenefit" class="nav-link">회원등급혜택</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/premium" class="nav-link">수수료관리</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/board/manageqna" class="nav-link">관리문의게시판</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/category" class="nav-link">카테고리 관리</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/blocklist" class="nav-link">차단된 회원 목록</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/goods/list" class="nav-link">상품 목록</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/basicpagesetting" class="nav-link">사이트 기본 정보 관리</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/calculate/total" class="nav-link">정산</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/logout" class="nav-link">로그아웃</a></li>
          </ul>
        </div>  
      </nav>