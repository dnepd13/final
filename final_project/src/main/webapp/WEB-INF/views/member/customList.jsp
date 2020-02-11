<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h3>member Custom List.jsp</h3>

<h4>받은 견적서 전부 보여주기</h4>
<div>
<c:forEach var="sellerResp" items="${getListResp }">
	보낸사람: ${sellerResp.seller_id } <br>
	제목: <a href="customInfoResp?seller_custom_order_no=${sellerResp.seller_custom_order_no }">
						${sellerResp.custom_order_title }
			</a> <br>	
	작성일: ${sellerResp.custom_order_date } <br>
	<hr>
</c:forEach>
</div>

<h4>보낸 요청서</h4>
<c:forEach var="memberCustom" items="${getListReq }">
<div>
	<p style="textalign:right"><a href="#">삭제</a></p>
	<a href="customInfoReq?custom_order_no=${memberCustom.custom_order_no }">
		제목: ${memberCustom.custom_order_title }
	</a> <br>
	작성일: ${memberCustom.custom_order_date }
	<hr>
</div>
</c:forEach>
