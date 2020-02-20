<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
// 구매확정-리뷰쓰기 버튼 전환
	$(function(){
		$(".orderConfirm").click(function(){
			if(confirm("구매를 확정하시겠습니까?")){
				$(this).hide();
				$(this).next(".btn_review").show();
			}
			else{
				return false;
			}
		});
		
//	리뷰작성
		$(".btn_review").click(function(){
			if($(this).text()=="리뷰쓰기"){
				$(this).next(".insertReview").show();
				$(this).text("취소");
				
				$(this).next(".form").submit(function(e){
					e.preventDefault();
					console.log($(this));
				});
			}
			
			else{
				$(this).next(".insertReview").hide();
				$(this).text("리뷰쓰기");
			}
		});

	});
</script>
<style>
	* {box-sizing: border-box;}
	table {border-collapse: collapse;}
</style>

<h4>회원 주문내역페이지 member/orderingList.jsp</h4>

<table border="1">
	<thead>
		<tr>
			<th>주문내역 PK</th>
			<th>주문번호</th>
			<th>배송지</th>
			<th>수량</th>
			<th>가격</th>
			<th>결제상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="cartList" items="${getCartList }">
		<tr>
			<td>${cartList.cart_info_no }</td>
			<td>${cartList.partner_order_id }</td>
			<td><h5>우편번호 ${cartList.cart_info_addr_post }</h5>
					${cartList.cart_info_addr_basic }<br>${cartList.cart_info_addr_extra }</td>
			<td>${cartList.total_quantity } 개</td>
			<td>${cartList.total_price } 원<h6>배송금액: ${cartList.total_delivery_price } 원</h6></td>
			<td>${cartList.cart_info_status }	
					<c:set var="cartStatus" value="${cartList.cart_info_status }"/>
					<c:if test="${functions: contains(cartStatus, '결제완료') }">
						<button class="orderConfirm">구매확정</button>
						<button class="btn_review" style="display:none;">리뷰쓰기</button>
						<form action="insertReview" method="post" enctype="multipart/form-data" class="insertReview" style="display:none;">
							<input type="hidden" name="cart_info_no" value="${cartList.cart_info_no }">
							<input type="hidden" name="member_no" value="${cartList.member_no }">
							<input type="file" name="files" multiple><br>
							<textarea name="goods_review_content" required>	</textarea>
							<input type="submit" value="리뷰등록">
						</form>
					</c:if>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
