<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
    
    <h1>판매자 로그인페이지</h1>
<form action="login" method="post">
아이디 <input type="text" name="seller_id" ><br><br>
비밀번호 <input type="text" name="seller_pw" ><br><br>
<input type="submit" value="로그인하기">

</form>
<form action="find" method="get">
<input type="submit" value="아이디" ><input type="submit" value="비밀번호 찾기" >
</form>