<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
    
    
<h1>회원 탈퇴</h1>

<form action="memberdelete" method="post">
<h3><input type="password" name="member_pw" >비밀번호 확인</h3>
<h3><input type="password" name="member_pw">비밀번호 재확인</h3>
<input type="submit" value="탈퇴">
</form>
