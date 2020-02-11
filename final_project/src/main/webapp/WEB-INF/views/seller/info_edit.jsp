<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>판매자 정보 수정 페이지</h1>
         <form action="info_edit" method="post">
         판매자 이메일 <input type="text" name="seller_email" ><br><br>
         판매자 대표자 전화번호<input type="text" name="seller_phone" ><br><br>
         판매자 사업장 전화번호<input type="text" name="seller_store_phone" ><br><br>
         판매자 사업장 팩스번호<input type="text" name="seller_store_fax" ><br><br>
         판매자 사업장 은행명(코드)<input type="text" name="seller_bank_code" ><br><br>
         판매자 사업장 은행계좌번호<input type="text" name="seller_bank_account" ><br><br>
         판매자 사업장 은행예금주<input type="text" name="seller_bank_username" ><br><br>
         판매자 사업장 은행 주민 등록번호<input type="text" name="seller_bank_birth" ><br><br>
         <input type="submit" value="수정하기">
         </form>
