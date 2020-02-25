<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>이용약관동의페이지</h1>

<form action="regist_agree" method="post">
<input type="radio">이용약관, 개인정보 수집 및 이용, 위치정보 이용약관(선택),
프로모션 안내 메일 수신(선택)에 모두 동의합니다.<br><br>
<input type="radio">이용약관동의(필수)<br><br>
<textarea rows="10" cols="80"></textarea><br><br>
<input type="radio">개인정보 수집 및 이용에 대한 안내(필수)<br><br>
<textarea rows="10" cols="80"></textarea><br><br>
<input type="radio">위치정보 이용약관 동의(선택)<br><br>
<textarea rows="10" cols="80"></textarea><br><br>
<input type="radio">이벤트 등 프로모션 알림 메일 수신(선택)<br><br>
<input type="hidden" name=seller_agree_date value="${dTime }">
<input type="submit" value="취소">
<input type="submit" value="확인">

</form>
