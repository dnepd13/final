<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>배송지 상세정보</h1>

<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

<div>
<c:forEach var="Addrinfo" items="${addrinfo}">
	<h3>${Addrinfo.member_addr_no}</h3>
	<h3>배송지 아이디:${Addrinfo.member_name_extra}</h3><br>
	<h3>배송지 우편번호:${Addrinfo.member_addr_post}</h3><br>
	<h3>배송지 기본주소:${Addrinfo.member_addr_basic}</h3><br>
	<h3>배송지 상세주소:${Addrinfo.member_addr_extra}</h3><br>
	<h3>배송지 주소타입:${Addrinfo.member_addr_status}</h3><br>
	<!-- <p><button type="button" onclick="location.href='ordering/member/insertaddr'"></a> -->
</c:forEach>
</div>