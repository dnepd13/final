<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h3>Seller Custom Info Resp.jsp</h3>
	
<h4>보낸 견적서 상세내용</h4>
	<div>
	제목: ${getListInfoResp.custom_order_title } <br>
	상세내용 <br>
	${getListInfoResp.custom_order_content } <br>
	견적가격: ${getListInfoResp.custom_order_price } <br>
	가능날짜: ${getListInfoResp.custom_order_hopedate } <br>
	현재상태: ${getListInfoResp.custom_order_status }	
	<hr>
	</div>