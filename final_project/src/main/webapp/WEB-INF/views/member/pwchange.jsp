<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

<h1>비밀번호 변경</h1>

<form action="pwchange" method="post">
	<input type="password" name="member_pw" placeholder="비밀번호" required>
	<input type="submit" value="비밀번호 변경하기">
</form> 