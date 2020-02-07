<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h3>member Custom List.jsp</h3>

<h4>받은 견적서 전부 보여주기</h4>
	<table>
		<tr>
			<th>견적서 제목</th>
			<th>견적서 내용</th>
			<th>견적서 가격</th>
			<th>견적서 가능기간</th>
			<th></th>
		</tr>
		<c:forEach var="sellerCustom" items="${getListCustom }">
		<tr>
			<td>${sellerCustom.custom_order_title }</td>
			<td>${sellerCustom.custom_order_content }</td>
			<td>${sellerCustom.custom_order_price }</td>
			<td>${sellerCustom.custom_order_hopedate }</td>
			<td><a href="">수락 및 결제하기</a></td>		
		</tr>
		</c:forEach>
	</table>

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
			<td>견적대기중</td>		
		</tr>
		</c:forEach>
	</table>
