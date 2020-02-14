<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h3>seller Custom Info Req.jsp</h3>
	
<h4>받은 요청서 상세내용</h4>
	
	<div>
	보낸사람: ${getListInfoReq.member_id } <br>
	제목: ${getListInfoReq.custom_order_title } <br>
	상세내용 <br>
	${getListInfoReq.custom_order_content } <br>
	희망가격: ${getListInfoReq.custom_order_price } <br>
	희망날짜: ${getListInfoReq.custom_order_hopedate } <br>
	첨부파일<br>
	<c:forEach var="filesVO" items="${filesVO }">
		<img src="http://localhost:8080/ordering/member/download?files_no=${filesVO.files_no }" width=100px; height=100px;>
	</c:forEach>
	<br>
	<a href="customOrder?member_no=${getListInfoReq.member_no }">견적서 보내기</a>	
	<hr>
	</div>

    
