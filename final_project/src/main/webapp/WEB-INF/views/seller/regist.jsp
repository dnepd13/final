<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>regist.jsp</h1>
<h1>회원가입 페이지</h1>
<form action="regist" method="post">
판매자 아이디 <input type="text" name="seller_id"><br><br>
판매자 비밀번호 <input type="text" name="seller_pw"><br><br>
판매자 대표자 이름 <input type="text" name="seller_name"><br><br>
판매자 이메일 <input type="text" name="seller_email"><br><br>
판매자 대표자 전화번호 <input type="tel" name="seller_phone"><br><br>
판매자 주민등록번호/사업자번호 <input type="number" name="seller_birth"><br><br>
판매자 사업장 우편번호 <input type="text" name="seller_addr_post"><br><br>
판매자 사업장 기본주소 <input type="text" name="seller_addr_basic"><br><br>
판매자 사업장 상세주소 <input type="text" name="seller_addr_extra"><br><br>
판매자 사업장 이름 <input type="text" name="seller_store_name"><br><br>
판매자 사업장 전화번호 <input type="tel" name="seller_store_phone"><br><br>
판매자 사업장 팩스번호 <input type="number" name="seller_store_fax"><br><br>
판매자 사업장 은행명(코드) <input type="text" name="seller_bank_code"><br><br>
판매자 사업장 은행계좌번호 <input type="text" name="seller_bank_account"><br><br>
판매자 사업장 은행예금주 <input type="text" name="seller_bank_username"><br><br>
판매자 사업장 은행 주민 등록번호 <input type="text" name="seller_bank_birth"><br><br>
<input type="hidden" name=seller_agree_date" value="${dTime }">
<input type="submit" value="가입하기">
</form>