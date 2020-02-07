<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>판매자 정보 조회 페이지</h1>

<form action="info" method="post">
<h3>판매자 아이디 :${seller_id}</h3> 
<h3>판매자 이름:${seller_name}</h3>
<h3>판매자이메일 : ${seller_email}</h3>
<h3>판매자 대표자 전화번호 : ${seller_phone}</h3>
<h3>판매자 주민등록번호/사업자번호:${seller_birth}</h3>
<h3>판매자 사업장 우편번호: ${seller_addr_post}</h3>
<h3>판매자 사업장 기본주소: ${seller_addr_basic}</h3>
<h3>판매자 사업장 상세주소 : ${seller_addr_extra}</h3>
<h3>판매자 사업장 이름 : ${seller_store_name}</h3>
<h3>판매자 사업장 전화번호 : ${seller_store_phone}</h3>
<h3>판매자 사업장 팩스번호 : ${seller_store_fax} </h3>
 <h3>판매자 사업장 은행명(코드) : ${seller_bank_code} </h3>
 <h3>판매자 사업장 은행 계좌번호 : ${seller_bank_account} </h3>
 <h3>판매자 사업장 은행 예금주 : ${seller_bank_username} </h3>
 <h3>판매자 사업장 은행 주민 등록번호 : ${seller_bank_birth} </h3>
 <h3>판매자 등급 : ${seller_grade}</h3>               		                                                       
<input type="submit" value="정보 수정하기">
</form>