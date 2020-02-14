<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<h1>관리자 가입</h1>
<form action="" method="post">
	아이디<input type="text" name="admin_id"><br>
	비밀번호<input type="password" name="admin_pw"><br>
	이름<input type="text" name="admin_name"><br>
	이메일<input type="text" name="admin_email"><br>
	<input type="submit" value="관리자가입">
</form>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>