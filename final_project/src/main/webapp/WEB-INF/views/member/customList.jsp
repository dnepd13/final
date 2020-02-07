<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h3>member Custom List.jsp</h3>

<h4>받은 견적서 전부 보여주기</h4>
<c:forEach var="sellerCustom" items="${getListCustom }">
	<div>
	보낸사람: ${sellerCustom.member_id } <br>
	제목: <a href="customInfoResp?custom_order_no=${sellerCustom.custom_order_no }">
						${sellerCustom.custom_order_title }
			</a> <br>	
	작성일: ${sellerCustom.custom_order_date } <br>
	<hr>
	</div>
</c:forEach>

<h4>보낸 요청서</h4>
	<table>
		<tr>
			<th>요청서 제목</th>
			<th>요청서 내용</th>
			<th>요청서 가격</th>
			<th>요청서 희망기간</th>
			<th>요청상태</th>
		</tr>
		<c:forEach var="memberCustom" items="${getListReq }">
		<tr>
			<td>${memberCustom.custom_order_title }</td>
			<td>${memberCustom.custom_order_content }</td>
			<td>${memberCustom.custom_order_price }</td>
			<td>${memberCustom.custom_order_hopedate }</td>
			<td>${memberCustom.custom_order_status }</td>		
		</tr>
		</c:forEach>
	</table>
