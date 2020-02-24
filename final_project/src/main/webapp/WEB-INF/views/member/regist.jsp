<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>


<h1>회원가입</h1>

    <form action="regist" method="post">
	    
	    <input type="text" name="member_id" placeholder="아이디를 입력하세요">
	    <br><br>
    	<input type="password" name="member_pw" placeholder="비밀번호를 입력하세요">
    	<br><br>
    	<input type="text" name="member_name" placeholder="이름을 입력하세요">
    	<br><br>
    	<input type="text" name="member_email" placeholder="이메일 주소를 입력하세요">
    	<br><br>
		<input type="text" name="member_phone" placeholder="휴대폰 번호를 입력하세요(-는빼고 11자리를 입력하시면 됩니다)">
		<br><br>
    	<input type="text" name="member_birth" placeholder="생년월일을 입력하세요 (ex: 19890101)">
    	<br><br><br><br>
    	
  
    	<input type="submit" value="회원가입">
    </form>