<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<h3>seller Custom List.jsp</h3>
	
<h4>요청서 목록</h4>
<c:forEach var="memberReq" items="${getListReq }">
	<div>
	보낸사람: ${memberReq.member_id } <br>
	제목: <a href="customInfoReq?member_custom_order_no=${memberReq.member_custom_order_no }">
						${memberReq.custom_order_title }
			</a> <br>	
	작성일: ${memberReq.custom_order_date } <br>
	<hr>
	</div>
</c:forEach>

<h4>보낸 견적서</h4>
<c:forEach var="sellerCustom" items="${getListResp }">
	<div>
	제목: <a href="customInfoResp?custom_order_no=${sellerCustom.custom_order_no }">
						${sellerCustom.custom_order_title }
			</a> <br>	
	작성일: ${sellerCustom.custom_order_date } <br>
	<hr>
	</div>
</c:forEach>