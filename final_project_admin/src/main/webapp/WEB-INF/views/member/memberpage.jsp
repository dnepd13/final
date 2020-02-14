<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>회원 상세보기</h1>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 

<c:if test="${admin_grade == '총괄관리자' }">
<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/member/delete?member_no=${one.member_no }"><button type="button" class="btn btn-primary">삭제</button></a>
</div>
</c:if>
<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/member/point?member_no=${one.member_no }&member_id=${one.member_id}"><button type="button" class="btn btn-primary">포인트조회</button></a>
</div>
<h1>회원 아이디 ${one.member_id }</h1>
<h1>회원 이름 ${one.member_name }</h1>
<h1>회원 이메일 ${one.member_email }</h1>
<h1>회원 연락처 ${one.member_phone }</h1>
<h1>회원 가입일 ${one.member_join_date }</h1>
<h1>회원 최종 로그인 ${one.member_last_login }</h1>
<h1>회원 동의 날짜 ${one.member_agree_date }</h1>
<h1>회원 등급 ${one.member_grade }</h1>
