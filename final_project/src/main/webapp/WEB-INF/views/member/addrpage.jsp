<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    


<h1>선택된 배송지 상세</h1>

<div>
<h1><a href="${pageContext.request.contextPath}/">홈으로</a></h1>


	<h3>배송지 번호:${addrone.member_addr_no}</h3>
	<h3>배송지 수신인:${addrone.member_name_extra}</h3>
	<h3>배송지 우편번호:${addrone.member_addr_post}</h3>
	<h3>배송지 기본주소:${addrone.member_addr_basic}</h3>
	<h3>배송지 상세주소:${addrone.member_addr_extra}</h3>
	<h3>배송지 주소타입:${addrone.member_addr_status}</h3>
<div class="btn-group-vertical">
		<a href="${pageContext.request.contextPath}/member/addrupdate?member_addr_no=${addrone.member_addr_no}">
			 <button type="button" class="btn btn-primary">주소지 수정</button>
		</a>
	</div>
</div>
