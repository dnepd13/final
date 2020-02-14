<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
		<h3>
			<form action="memberedit" method="post">
				<input type="hidden" name="member_no" value="${memberGetOne.member_no}">
				<input type="text" name="member_email" value="${memberGetOne.member_email}" required="required">
				<input type="text" name="member_phone" value="${memberGetOne.member_phone}" required="required">
				<input type="submit" value="회원정보수정">
			</form>
		</h3>