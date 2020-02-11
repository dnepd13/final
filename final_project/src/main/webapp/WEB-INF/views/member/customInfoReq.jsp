<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
 <h4>보낸 요청서 상세내용 member Custom Info Req.jsp</h4>   
	제목: ${getListInfoReq.custom_order_title } <br>
	상세내용 <br>
	${getListInfoReq.custom_order_content } <br>
	희망가격: ${getListInfoReq.custom_order_price } <br>
	희망날짜: ${getListInfoReq.custom_order_hopedate } <br>
	현재상태: ${getListInfoReq.custom_order_status }
<hr>