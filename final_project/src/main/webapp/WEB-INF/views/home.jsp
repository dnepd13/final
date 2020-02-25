<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

