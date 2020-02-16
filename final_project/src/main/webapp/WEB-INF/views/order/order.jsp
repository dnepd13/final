<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script>
$(function(){
	
	// 삭제 버튼
	$(".delete_btn").click(function(){
		$(this).parent(".items_area").remove();
		ordering_price_update();
	});
	
	ordering_price_update();
	
	function ordering_price_update(){
		console.log("프라이스업데이트 호출");
		var ordering_price = 0;
		var delivery_price = "${deliveryDto.delivery_price}";
		
		// 아이템 별 금액 합산
		$(".items_area").each(function(){
			ordering_price += parseInt($(this).children(".hItem_price").val());
		});
		
		
		// 배송 조건
		switch ("${deliveryDto.delivery_option}") {
		case '무료':
// 			delivery_price = 0;
			deliveryPriceUpdate(0);
			break;
		case '유료': 
			deliveryPriceUpdate(delivery_price);
			break;
		case '조건부무료':
			if(ordering_price>="${deliveryDto.delivery_set_op_price}") {
// 				delivery_price = 0;
				deliveryPriceUpdate(0);
			} else deliveryPriceUpdate(delivery_price);
			break;
		default:
			break;
		}
		
		
		// 묶음 배송
		
		
		
		// 배송비, 총 상품금액 출력	
		if(ordering_price == 0) {
			delivery_price = 0;
			deliveryPriceUpdate(0);
			$(".ordering_btn").attr("disabled", true);
		} 
		$(".ordering_price").html(addComma(String(ordering_price))+" 원");
	}
	
	function addComma(num){
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
	function deliveryPriceUpdate(delivery_price){
		$(".delivery_price").html(delivery_price + "원");
	}
});
</script>



<!-- c --> -->
<div class="ordering_area">
	<form action="" method="post">
	<h2>선택한 상품 목록</h2>
	<c:forEach items="${cartVOList}" var="cartVO">
	<div class="items_area">
	<hr>
		상품이름 : ${cartVO.goodsDto.goods_name}<br>
		상품가격 : <fmt:formatNumber pattern="###,###,###" type="number">${cartVO.goodsDto.goods_price}</fmt:formatNumber> 원<br>
		옵션 	: <br>
		<c:forEach items="${cartVO.option_list}" var="goodsOptionDto">
			- ${goodsOptionDto.goods_option_title } : 
			${goodsOptionDto.goods_option_content}  
			(<fmt:formatNumber pattern="###,###,###" type="number"> ${goodsOptionDto.goods_option_price}</fmt:formatNumber>원)
			<br>
		</c:forEach>
		가격 : <fmt:formatNumber pattern="###,###,###" type="number">${cartVO.price}</fmt:formatNumber> 원<br>	
		수량 : ${cartVO.quantity} 개 <br>
		총 가격 : 
			<span class="item_pirce">
			<fmt:formatNumber pattern="###,###,###" type="number">
			${cartVO.price*cartVO.quantity}</fmt:formatNumber> 원</span>
			<input type="hidden" class="hItem_price" value="${cartVO.price*cartVO.quantity}">
		<button class="delete_btn">삭제</button>
	</div>
	</c:forEach>
	<hr>
	배송비 : <span class="delivery_price">1 원</span>
	주문 총 가격 : <span class="ordering_price"> 원</span>
	<hr>
	<button class="ordering_btn">결제하기</button>
	</form>
	<hr>
	배송정보<br>
	${deliveryDto}
	<hr>	
</div>

