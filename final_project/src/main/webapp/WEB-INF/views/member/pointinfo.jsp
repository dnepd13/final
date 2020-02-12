<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>포인트 상세정보</h1>

<h1><a href="${pageContext.request.contextPath}/home">홈페이지로</a></h1>

<div>
<c:forEach var="Pointinfo" items="${pointinfo}">
	<h3>${Addrinfo.member_addr_no}</h3>
	
	<h3>${Pointinfo.member_point_no}</h3>
	<h3>포인트 상태창: ${Pointinfo.member_point_status}</h3>
	<h3>포인트 적립날짜: ${Pointinfo.member_point_date}</h3>
	<h3>포인트 유효기간: ${Pointinfo.member_point_limit}</h3>
	<h3>포인트 변동금액: ${Pointinfo.member_point_change}</h3>

</c:forEach>
</div>