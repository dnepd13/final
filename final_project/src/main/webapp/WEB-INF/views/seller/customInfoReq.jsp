<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h3>seller Custom Content.jsp</h3>
	
<h4>요청서 상세내용</h4>
	
	<div>
	보낸사람: ${getCustomInfo.member_id } <br>
	제목: ${getCustomInfo.custom_order_title } <br>
	상세내용 <br>
	${getCustomInfo.custom_order_content } <br>
	희망가격: ${getCustomInfo.custom_order_price } <br>
	희망날짜: ${getCustomInfo.custom_order_hopedate } <br>
	<a href="customOrder">견적서 보내기</a>	
	<hr>
	</div>

<h4>보낸 견적서</h4>
    
