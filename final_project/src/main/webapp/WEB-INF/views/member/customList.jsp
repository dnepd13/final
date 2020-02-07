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
<c:forEach var="memberCustom" items="${getListReq }">
	<div>
	<a href="customInfoResp?custom_order_no=${memberCustom.custom_order_no }">
		제목: ${memberCustom.custom_order_title }
	</a> <br>
	작성일: ${memberCustom.custom_order_date }
	<hr>
	</div>
</c:forEach>
