<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
 <h4>보낸 요청서 상세내용 member Custom Info Req.jsp</h4>
 	카테고리: ${category.category_large } / ${category.category_middle } / ${category.category_small } <br>   
	제목: ${getListInfoReq.custom_order_title } <br>
	상세내용 <br>
	${getListInfoReq.custom_order_content } <br>
	희망가격: ${getListInfoReq.custom_order_price } <br>
	희망날짜: ${getListInfoReq.custom_order_hopedate } <br>
	<c:if test="${ not empty filesVO }">
	첨부파일<br>
		<c:forEach var="filesVO" items="${filesVO }">
			<img src="http://localhost:8080/ordering/member/download?files_no=${filesVO.files_no }" width=100px; height=100px;>
		</c:forEach>
	</c:if>
	<br>
	현재상태: ${getListInfoReq.custom_order_status }
<hr>