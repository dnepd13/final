<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>홈</h1>

<!-- 바뀐 session의 member_no에서 memeber_id를 구해서 확인  -->

<!-- 로그인 내용  -->
<c:if test="${member_id == null}">
<form role="form" method="post" autocomplete="off" action="/member/login">

	<p><a href="/ordering/member/login">로그인</a></p>
	<p><a href="/ordering/member/regist">회원가입</a></p>

</form>
</c:if>


<c:if test="${member_id != null}">
<p>${member_id}님 환영합니다.</p>
<h1><a href="/ordering/member/membermyinfo">마이페이지</a></h1>
<h1><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></h1><br>
</c:if>