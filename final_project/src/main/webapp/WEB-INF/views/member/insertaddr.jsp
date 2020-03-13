<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<h1>배송지 추가 테이블</h1>

<form action="insertaddr" method="post">
	
	<input type="text" name="member_name_extra" placeholder="받으시는분 이름을 입력하세요" maxlength="19" required><br><br>
	<input type="text" name="member_addr_post" placeholder="우편번호를 입력하세요" maxlength="8" required><br><br>
	<input type="text" name="member_addr_basic" placeholder="우편 기본주소를 입력하세요" maxlength="68" required><br><br>
	<input type="text" name="member_addr_extra" placeholder="우편 상세주소를 입력하세요" maxlength="68" required><br><br>
	
	<br><br>
	<input type="submit" value="배송지 추가">

</form>

