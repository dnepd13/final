<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<h3>seller Custom List.jsp</h3>
	
<h4>받은 요청서 전부 보여주기</h4>
<c:forEach var="memberCustom" items="${getListCustom }">
	<div>
	보낸사람: ${memberCustom.member_id } <br>
	제목: <a href="customContent?custom_order_no=${memberCustom.custom_order_no }">
						${memberCustom.custom_order_title }
			</a> <br>	
	<hr>
	</div>
</c:forEach>

<h4>보낸 견적서</h4>