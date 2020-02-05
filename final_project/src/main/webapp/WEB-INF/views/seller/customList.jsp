<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<h3>seller Custom List.jsp</h3>
	
<h4>받은 요청서 전부 보여주기</h4>
	<table>
		<tr>
			<th>요청서 제목</th>
			<th>요청서 내용</th>
			<th>요청서 가격</th>
			<th>요청서 희망기한</th>
			<th></th>
		</tr>
		<c:forEach var="memberCustom" items="${getListCustom }">
		<tr>
			<td>${memberCustom.custom_order_title }</td>
			<td>${memberCustom.custom_order_content }</td>
			<td>${memberCustom.custom_order_price }</td>
			<td>${memberCustom.custom_order_hopedate }</td>
			<td><a href="customOrder">견적서 보내기</a></td>		
		</tr>
		</c:forEach>
	</table>

<h4>보낸 견적서</h4>