<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<div class="btn-group-vertical">

	<a href="${pageContext.request.contextPath}/member/addrRegist">
	</a>
	<a href="${pageContext.request.contextPath}/member/insertaddr">

		<button type="button" class="btn btn-primary">배송추가</button>
	</a>
</div>


<h1>배송지 상세정보</h1>

<h1><a href="${pageContext.request.contextPath}/">홈으로</a></h1>

<table align="center">
<thead>
	<tr>
	<th width="10%">배송지 번호</th>
	<th width="10%">배송지 수신인</th>
	<th width="20%">배송지 우편번호</th>
	<th width="20%">배송지 기본주소</th>
	<th width="20%">배송지 상세주소</th>
	<th width="10%">배송지 주소타입</th>
    </tr>	
</thead>

	<tbody>
	<c:forEach var="addrinfo" items="${addrinfo}">
	<tr align="center">	
		<td width="10%">${addrinfo.member_addr_no}</td>
		<td width="10%">${addrinfo.member_name_extra}</td>
		<td width="20%">${addrinfo.member_addr_post}</td>
		<td width="20%">${addrinfo.member_addr_basic}</td>
		<td width="20%">${addrinfo.member_addr_extra}</td>
		<td width="10%">${addrinfo.member_addr_status}</td>
		<td>
			<form action="addrpage" method="get">
				<input type="hidden" name="member_addr_no" value="${addrinfo.member_addr_no}">
				<input type="submit" value="수정하기">
			</form>
			<form action="addrdelete" method="post">
				<input type="hidden" name="member_addr_no" value="${addrinfo.member_addr_no}">
				<input type="submit" value="배송지삭제">
			</form>
		</td>
	</tr>
	</c:forEach>
	
	</tbody>
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>