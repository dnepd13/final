<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">       

<h1>회원 정보 수정 테이블</h1>

<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

	<h3>회원 아이디:${memberGetOne.member_id}</h3>
	<h3>회원 이름:${memberGetOne.member_name}</h3>
	<h3>회원 이메일:${memberGetOne.member_email}</h3>
	<h3>회원 전화번호:${memberGetOne.member_phone}</h3>
	<h3>회원 생년월일:${memberGetOne.member_birth}</h3>
	<h3>회원 가입일시:${memberGetOne.member_join_date}</h3>
	<h3>회원 최종로그인:${memberGetOne.member_last_login}</h3>
	<h3>회원 등급:${memberGetOne.member_grade}</h3>
	<div class="btn-group-vertical">
		<a href="${pageContext.request.contextPath}/member/editmember?member_no=${memberGetOne.member_no}">수정<button type="button" class="btn btn-primary"></button></a>
	</div> 