<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<h1>선택된 배송지 정보</h1>

<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>


	<h3>배송지 번호:${addrone.member_addr_no}</h3>
	<h3>배송지 수신인:${addrone.member_name_extra}</h3>
	<h3>배송지 우편번호:${addrone.member_addr_post}</h3>
	<h3>배송지 기본주소:${addrone.member_addr_basic}</h3>
	<h3>배송지 상세주소:${addrone.member_addr_extra}</h3>
	<h3>배송지 주소타입:${addrone.member_addr_status}</h3>
		<h3>
			<form action="addrpage" method="post">
				<input type="hidden" name="member_addr_no" value="${addrone.member_addr_no}">
				<input type="text" name="member_name_extra" value="${addrone.member_name_extra}" required="required">
				<input type="text" name="member_addr_post" value="${addrone.member_addr_post}" required="required">
				<input type="text" name="member_addr_basic" value="${addrone.member_addr_basic}" required="required">
				<input type="text" name="member_addr_extra" value="${addrone.member_addr_extra}" required="required">
				<input type="text" name="member_addr_status" value="${addrone.member_addr_status}" required="required">
				<input type="submit" value="수정">
			</form>
		</h3>
