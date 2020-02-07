<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h3>seller Custom Content.jsp</h3>
	
<h4>받은 견적서 전부 보여주기</h4>
	
	<div>
	보낸사람: ${getCustomInfo.seller_id } <br>
	제목: ${getCustomInfo.custom_order_title } <br>
	상세내용 <br>
	${getCustomInfo.custom_order_content } <br>
	견적가격: ${getCustomInfo.custom_order_price } <br>
	가능날짜: ${getCustomInfo.custom_order_hopedate } <br>
	<a href="#">수락 및 결제하기</a>	
	<hr>
	</div>

 <h4>보낸 요청서 상세내용</h4>   
<c:forEach var="memberCustom" items="${getListReq }">
	보낸사람:
	제목: ${memberCustom.custom_order_title } <br>
	상세내용 <br>
	${memberCustom.custom_order_content } <br>
	희망가격: ${memberCustom.custom_order_price } <br>
	희망날짜: ${memberCustom.custom_order_hopedate } <br>
	현재상태: ${memberCustom.custom_order_status }
	<hr>
</c:forEach>