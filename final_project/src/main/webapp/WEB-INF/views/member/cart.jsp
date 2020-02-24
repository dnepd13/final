<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
장바구니페이지

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script>
$(function(){
	
	// 배송비, 배송조건, 배송조건금액, 묶음 배송, 묶음 배송 조건
	// 보내야 할 정보
	
// 	@ 상품정보 (상품1개 + 옵션) 
// 	@ 배송지 
// 	@ 사용된 포인트
// 	@ 총 수량
// 	@ 총 금액(상품전체+배송비-포인트+부가세)
// 	@ 총 배송비

	
var jsCartVOList = JSON.parse('${jsonCartVOList}');
var jsGoodsCartNoList = JSON.parse('${jsGoodsCartNoList}');
	
// 초기화
var total_delivery_price = deliveryPriceUpdate();
var g_total_price = orderingPriceUpdate(total_delivery_price);
deliveryPriceTagUpdate(total_delivery_price);
	
///////// 배송비 업데이트
function deliveryPriceUpdate() {
		var setList = new Array();
		var nonSetList = new Array();
		var nonFreePriceList = new Array();
		var total_delivery_price = 0;
		var isNonFree = false;
		var setSumPrice = 0;
		var set_op_price = 0;
		var op_max_price = 0;
		
		// 묶음 배송 검사
		jsCartVOList.forEach(function(cartVO, i){
			if(cartVO != ""){
				if(jsCartVOList[i].deliveryDto.delivery_set_agree == 'Y'){
					setList.push(jsCartVOList[i]);
				}  
				else nonSetList.push(jsCartVOList[i]);
			}
		});
		
		
	///// 묶음 배송 Y  ///// 
	setList.forEach(function(cartVO, i){
		if(cartVO != ""){
			// 배송 조건  별 로직
			switch (setList[i].deliveryDto.delivery_option) {
			case '무료':	break;
			
			// 유료있으면 true
			case '유료':  
				isNonFree = true;
				nonFreePriceList.push(setList[i].deliveryDto.delivery_price);
			break;
			
			case '조건부무료': 
				// true면 브레이크
				if(isNonFree) break;
				else {
					// 조건부무료 최고 금액 추출
					if(set_op_price < setList[i].deliveryDto.delivery_set_op_price){
						set_op_price = setList[i].deliveryDto.delivery_set_op_price;
					}
					// 배송비 최고 금액 추출
					if(op_max_price < setList[i].deliveryDto.delivery_price) {
						op_max_price = setList[i].deliveryDto.delivery_price;
					}	
					// 묶음 상품 금액 합계
					setSumPrice += (setList[i].price * setList[i].quantity);
					break;
				}
			
			default:
				break;
			}
		}
	});

	// 묶음 배송 Y 결과 
	// 유료가 있다면?
	if(isNonFree) {
		nonFreePriceList.forEach(function(nonFreePrice, i){
			if(nonFreePrice != ""){
				if(total_delivery_price < nonFreePriceList[i]){
					total_delivery_price = nonFreePriceList[i];
				}
			}
		});
	} 
	// 유료와 조건부무료 조건이 없다면?
	else if(set_op_price == 0) {
		total_delivery_price = 0;
	}
			
	// 조건부 무료가 있다면?
	else {
		// 조건부 무료 최고 금액 < 묶음 상품 합계 금액  ? 0 : 조건부무료 배송비 최고 금액 
		total_delivery_price = (set_op_price < setSumPrice ? 0 : op_max_price);
	}
		
		
		
	///// 묶음 배송 N  ///// 
	nonSetList.forEach(function(nonSet, i){
		if(nonSet != ""){
			switch (nonSetList[i].deliveryDto.delivery_option) {
			case '무료':	break;
			case '유료': 
				total_delivery_price += nonSetList[i].deliveryDto.delivery_price;
				break;
			case '조건부무료': 
				// 상품가격이 
				if(nonSetList[i].price < nonSetList[i].deliveryDto.delivery_op_price){
					total_delivery_price += nonSetList[i].deliveryDto.delivery_price;
				}
				break;
			default:
				break;
			}
		}
	});
	
	deliveryPriceTagUpdate(total_delivery_price);
	
	return total_delivery_price;
}
	
	
////////// 삭제 버튼
$(".delete_btn").click(function(){
	// jsCartVOList에서 삭제하기 전에 디비에서 삭제
	var index = $(this).parent(".items_area").attr("id");
	$(this).parent(".items_area").remove();
	var url = "deleteCart";
	$.ajax({
		type: "POST",
		url: url,
		data:{'goods_cart_no': jsGoodsCartNoList[index]},
		success: function(){
			window.alert("삭제되었습니다!");
		}
	});
	
	setFinalArea();
	
	jsCartVOList[index] = "";
	orderingPriceUpdate(deliveryPriceUpdate());
});

////////// 주문하기



	
////////// 총금액 업데이트
function orderingPriceUpdate(total_delivery_price){
	var ordering_price = 0;
	var delivery_price = total_delivery_price;
	var total_price = 0;
	
	// 아이템 별 금액 합산
	jsCartVOList.forEach(function(cartVO, i){
		if(cartVO != "") total_price += (cartVO.price * cartVO.quantity);
	});
	
	// 총 상품금액 출력	
	total_price += delivery_price;
	if(total_price == 0){
		$(".ordering_btn").attr("disabled", true);
		deliveryPriceTagUpdate(0);
	}
	$(".ordering_price").html(addComma(String(total_price))+" 원");
	
	deliveryPriceTagUpdate(delivery_price);
	return total_price;
}


// 총 상품금액(수량) 업데이트
function setFinalArea(){
	
	var fPrice = 0;
	var fQuantity = 0;
	$(".items_area").each(function(){
		fQuantity += parseInt($(this).children(".quantity").val());
		fPrice += $(this).children(".hPrice").val() * parseInt($(this).children(".quantity").val());
	});
	
	$(".final_price").html(addComma(fPrice) + "원");
	$(".final_qtt").html(" ("+fQuantity+")개");
}

function addComma(num){
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}

///////  배송비 태그 업데이트
function deliveryPriceTagUpdate(delivery_price){
	$(".delivery_price").html(delivery_price + "원");
}

});
</script>


<form action="../order/order" method="POST">
<div class="ordering_area">
	<hr>
	<h2>장바구니 목록</h2>
	<c:forEach items="${cartVOList}" var="cartVO" varStatus="status">
	<div id="${status.index}" class="items_area">
	<input type="hidden" name="itemVOList[${status.index}].price" value="${cartVO.price}">
	<input type="hidden" name="itemVOList[${status.index}].quantity" value="${cartVO.quantity}">
	<input type="hidden" name="itemVOList[${status.index}].goods_no" value="${cartVO.goodsDto.goods_no}">
	<hr>
	<!-- 상품정보칸 -->
		상품이름 : ${cartVO.goodsDto.goods_name}<br>
		상품가격 : <fmt:formatNumber pattern="###,###,###" type="number">${cartVO.goodsDto.goods_price}</fmt:formatNumber> 원<br>
		
	<!-- 옵션칸 -->
		옵션 	: <br>
		<c:forEach items="${cartVO.option_list}" var="goodsOptionDto">
		<input type="hidden" name="itemVOList[${status.index}].option_no_list" value="${goodsOptionDto.goods_option_no}">
			- ${goodsOptionDto.goods_option_title } : 
			${goodsOptionDto.goods_option_content}  
			(<fmt:formatNumber pattern="###,###,###" type="number"> ${goodsOptionDto.goods_option_price}</fmt:formatNumber>원)
			<br>
		</c:forEach>
		가격 : <fmt:formatNumber pattern="###,###,###" type="number">${cartVO.price}</fmt:formatNumber> 원<br>	
		수량 : ${cartVO.quantity} 개 <br>
		
	<!-- 배송정보 칸 -->
		<div class="delivery_area">
		배송조건 : <span class="item_dOption">${cartVO.deliveryDto.delivery_option}</span>	<br>
		배송조건금액 : <span class="item_dOp_price">${cartVO.deliveryDto.delivery_op_price}</span><br>
		묶음배송여부 : <span class="item_dSet_agree">${cartVO.deliveryDto.delivery_set_agree }</span><br>
		묶음배송금액 : <span class="item_dSet_agree">${cartVO.deliveryDto.delivery_set_op_price }</span><br>
		배송비 : <span class="item_dPrice">${cartVO.deliveryDto.delivery_price}</span><br>
		택배사 : <span class="item_dCompany">${cartVO.deliveryDto.delivery_company}</span>
		</div>
	<!-- 토탈 -->
		<div class="total_area">
		총 가격 : 
			<span class="item_pirce">
			<fmt:formatNumber pattern="###,###,###" type="number">
			${cartVO.price*cartVO.quantity}</fmt:formatNumber> 원</span>
			<input type="hidden" class="hItem_price" value="${cartVO.price*cartVO.quantity}">
		</div>
		<button class="delete_btn">삭제</button>
	</div>
	</c:forEach>
	<hr>
	배송비 : <span class="delivery_price">1 원</span>
	주문 총 가격 : <span class="ordering_price"> 원</span>
	<hr>
	<input type="submit" value="주문하기">
	
	<hr>
</div>
</form>
