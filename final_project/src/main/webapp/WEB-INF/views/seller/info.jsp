<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>판매자 정보 조회 페이지</h1>
<form action="info" method="post">
<h3>판매자 아이디 :${sellerDto.seller_id}</h3> 
<h3>판매자 이름:${sellerDto.seller_name}</h3>
<h3>판매자이메일 : ${sellerDto.seller_email}</h3>
<h3>판매자 대표자 전화번호 : ${sellerDto.seller_phone}</h3>
<h3>판매자 주민등록번호/사업자번호:${sellerDto.seller_birth}</h3>
<h3>판매자 사업장 우편번호: ${sellerDto.seller_addr_post}</h3>
<h3>판매자 사업장 기본주소: ${sellerDto.seller_addr_basic}</h3>
<h3>판매자 사업장 상세주소 : ${sellerDto.seller_addr_extra}</h3>
<h3>판매자 사업장 이름 : ${sellerDto.seller_store_name}</h3>
<h3>판매자 사업장 전화번호 :${sellerDto.seller_store_phone}</h3>
<h3>판매자 사업장 팩스번호 : ${sellerDto.seller_store_fax} </h3>
 <h3>판매자 사업장 은행명(코드) :${sellerDto.seller_bank_code} </h3>
 <h3>판매자 사업장 은행 계좌번호 : ${sellerDto.seller_bank_account} </h3>
 <h3>판매자 사업장 은행 예금주 : ${sellerDto.seller_bank_username} </h3>
 <h3>판매자 사업장 은행 주민 등록번호 : ${sellerDto.seller_bank_birth} </h3>
 <h3>판매자 등급 :${sellerDto.seller_grade}</h3>    
 
 <input type="submit" value="판매자 정보 수정하러 가기"> <a href="management" >뒤로가기</a>
 </form>          		                                                       
