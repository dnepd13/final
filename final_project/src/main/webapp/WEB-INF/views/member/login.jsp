<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

<h1> 로그인 페이지 </h1>

<form action="login" method="post">
	<input type="text" name="member_id" placeholder="아이디"><br><br>
	<input type="password" name="member_pw"placeholder="비밀번호"><br><br>
	<input type="submit">

</form>