<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>Document</title>
    <style></style>
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/js/star/hakademy-star.min.js"></script>
    <script>
        window.addEventListener("load", function(){
            Hakademy.PointManager.factory(".star-wrap");
        });
    </script>

<style>
	* {box-sizing: border-box;}
	table {border-collapse: collapse;}
</style>

<h4>회원 주문내역페이지 member/orderingList.jsp</h4>

<table border="1">
		<tr>
			<th>주문번호</th>
			<th>상품명</th>
			<th>구매수량</th>
			<th>결제금액</th>
			<th>결제상태</th>
			<th>리뷰상태</th>
		</tr>
		<c:forEach var="getCart" items="${getCart }">
		<tr>
			<td>${getCart.partner_order_id }</td>
			<td>${getCart.goods_name }</td>
			<td>${getCart.cart_info_goods_quantity } 개</td>
			<td>${getCart.cart_info_goods_price } 원</td>
			<td><%-- ${getCartInfo.cart_info_status }	 --%>
<%-- 					<c:set var="cartStatus" value="${getCartInfo.cart_info_status }"/> --%>
<%-- 					<c:if test="${functions: contains(cartStatus, '결제완료') }"> --%>
						<button class="orderConfirm">구매확정</button>
						<button class="btn_review" style="display:none;">리뷰쓰기</button>
						
						<form action="insertReview" method="post" enctype="multipart/form-data" class="insertReview" style="display:block;">
							
							<input type="hidden" name="cart_info_no" value="${getCart.cart_info_goods_no }">
							<input type="hidden" name="member_no" value="${getCartInfo.member_no }">
							<div data-sendname="goods_review_star" class="star-wrap" data-limit="5" data-unitsize="20" data-image="http://www.sysout.co.kr/file/image/288"></div>
							<input type="file" name="files" multiple><br>
							<textarea name="goods_review_content" required>	</textarea>
							<input type="submit" value="리뷰등록">
							
							<input type="hidden" name="member_point_change" value="50">
							<input type="hidden" name="member_point_content" value="리뷰적립">
						</form>			
<%-- 					</c:if> --%>
			</td>
			<td><button>리뷰보기</button></td>
		</tr>
		</c:forEach>
</table>
<div></div>
