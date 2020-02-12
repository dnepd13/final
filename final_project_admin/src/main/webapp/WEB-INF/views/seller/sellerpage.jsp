<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 
<h1>판매자 관리 페이지입니다</h1>

<c:if test="${admin_grade == '총괄관리자' }">
<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/seller/delete?seller_no=${seller.seller_no }"><button type="button" class="btn btn-primary">삭제</button></a>
</div>
</c:if>

<h1>판매자 아이디 ${seller.seller_id }</h1>
<h1>판매자 이름 ${seller.seller_name }</h1>
<h1>판매자 이메일 ${seller.seller_email }</h1>
<h1>판매자 연락처 ${seller.seller_phone }</h1>
<h1>판매자 주민 뒤 6자는 ****** ${seller.seller_birth}</h1>
<%-- <h1>판매자 주민 뒤 6자는 ****** ${seller.seller_birth.substring(0,5) }-${seller.seller_birth.substring(5,6) }******</h1> --%>
<h1>판매자 포트스주소 ${seller.seller_addr_post }</h1>
<h1>판매자 기본주소 ${seller.seller_addr_basic }</h1>
<h1>판매자 상세주소 ${seller.seller_addr_extra }</h1>
<h1>판매자 상호명 ${seller.seller_store_name }</h1>
<h1>판매자 상호 연락처 ${seller.seller_store_phone }</h1>
<h1>판매자 상호 팩스 ${seller.seller_store_fax }</h1>
<h1>판매자 가입날짜 ${seller.seller_join_date }</h1>
<h1>판매자 마지막 로그인 ${seller.seller_last_login }</h1>
<h1>판매자 동의 시간 ${seller.seller_agree_date }</h1>
<h1>판매자 은행 번호 ${seller.seller_bank_code }</h1>
<h1>판매자 계좌 ${seller.seller_bank_account }</h1>
<h1>판매자 은행주 이름 ${seller.seller_bank_username }</h1>
<h1>판매자 등급 ${seller.seller_grade }</h1>
<h1>카테고리</h1>
<hr>

<h1>판매자 저번달 판매액</h1>
<h1>판매자 이번달 판매액</h1>
