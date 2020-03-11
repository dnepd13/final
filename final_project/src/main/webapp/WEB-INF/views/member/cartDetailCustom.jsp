<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
 
 <style>
	* {box-sizing: border-box;}
	
	.articleBox {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
	}
	.cartGoods {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 960px;
	}
	.goods_main {
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;
	}
	.goods_mainBox1 {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large; 
	}		
	.customContent {
		margin:30px auto;
		width: 90%;
	}
	
	table {
		border-collapse: collapse;
		margin: 0 auto;
		width: 90%;
		text-align: center;
	}	
	table .t_head {
		background-color: #F3F5F8;
	}
	.cartGoods table th {
		height: 30px;
	}
	.cartGoods table ul {
		list-style: none;
	}
 </style>
 
<article class="articleBox">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
<div class="cartGoods">
	<div class="goods_main">
		<div class="goods_mainBox1">
			주문상품 상세
		</div>
	</div>
	<div class="customContent">
	<table  border="1">
		<tr class="t_head">
			<th scope="col" width="50%">상품명</th>
			<th scope="col" width="10%">수량</th>
			<th scope="col" width="20%">가격</th>
			<th scope="col" width="20%">현재상태</th>
		</tr>
		<tr>
			<td style="text-align: left; padding: 10px;">${customOrder.custom_order_title}
				<ul style="margin-top:5px;; margin-bottom: 2px;">
					<li style="color: gray;"> - ${customOrder.custom_order_content }</li>
				</ul>
			</td>
			<td> 1 </td>
			<td>${customOrder.custom_order_price }</td>
			<td>${customOrder.custom_order_status }</td>
		</tr>
	</table>
	<div class="row-empty-20"></div>
	<p style="text-align: right;"><a href="${pageContext.request.contextPath }/member/cartList">목록으로</a></p>
	</div>	
		
</div>

</article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>