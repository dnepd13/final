<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"/>

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

if(g_total_price == 0) {
	$("#submit_btn").attr("disabled", true);
}

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
	var index = $(this).parents(".items_area").attr("id");
	$(this).parents(".items_area").remove();
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
	
	if(fPrice == 0) {
		$("#submit_btn").attr("disabled", true);
	}
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
<style>
.ordering_area {
	margin: 30px 0px;
}

.addr_table{
	border-top: 2px solid #171717;
	border-bottom: 1px solid #171717;
}

.cart_table {
	border-top: 2px solid #171717;
	border-bottom: 1px solid #171717;
}

.col-lg-8 {
	margin: 25px 0px;
}

.cart_table_title {
	border-bottom: 1px solid #171717;
}

.addr_table > tbody > tr > th {
	text-align: center;
}

.addr_table > tbody > tr > td {
	width: 75%;
	padding: 8px;
}

.table > tbody > tr > td > input {
	padding-left: 20px;
	border: none;
	background-color: #F2F2F2;
	width: 250px;
	height: 30px;
}

.addr_status {
	width: 250px;
	height: 30px;
	padding: 0px 12px;
}

.goods_info {
	width: 35%;
}

.delete_btn_area {
	width: 10%;
}

.total_table {
	border-top: 2px solid #171717;
	border-bottom: 1px solid #171717;
}

.total_table > tbody > tr > th {
	text-align: right;
	width: 20%;
}

.total_table > tbody > tr > td {
	width: 70%;
	padding-left: 20px;
}

.find_btn {
	margin-bottom: 5px;
}

#ordering_btn {
	height: 40px;
	font-size: 1rem;
}

.goods_image {
	width: 10%;
	height: 100%;
}

.goods_image > img {
	width: 100%;
	height: auto;
}

.op_info {
	margin-top: 10px;
}

.items_area {
	border-bottom: 1px solid #171717;
}

.info {
	padding-left: 10px;
}

.delivery_price {
	font-size: 1rem;
}

.ordering_price {
	font-size: 1rem;
}

.submit_area {
	margin: 15px 0px;
}

.cart_area {
	margin: 15px 0px;
}

#submit_btn {
	margin: 20px 0px;
	height: 40px;
	font-size: 1rem;
}

.submit_box {
	padding: 15px;
}

</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<form action="../order/order" method="POST">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
			<h3>장바구니</h3>
		</div>
		<table class="table table-borderless cart_table">
			<tr class="cart_table_title">
				<th colspan="3" scope="col" class="align-middle text-center" style="width: 33%">상품정보</th>
				<th scope="col" class="align-middle text-center" style="width: 13%">수량</th>
				<th scope="col" class="align-middle text-center" style="width: 20%">가격</th>
				<th scope="col" class="align-middle text-center" style="width: 20%">총 가격</th>
				<th scope="col" class="align-middle text-center" style="width: 13%">-</th>
			</tr>
			<c:forEach items="${cartVOList}" var="cartVO" varStatus="status">
				<tr id="${status.index}" class="items_area">
					<td>
						<input type="hidden" name="itemVOList[${status.index}].price" value="${cartVO.price}">
						<input type="hidden" name="itemVOList[${status.index}].quantity" value="${cartVO.quantity}">
						<input type="hidden" name="itemVOList[${status.index}].goods_no" value="${cartVO.goodsDto.goods_no}">
					</td>
					<td class="goods_image align-middle" style="width: 20%">
						<img src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${filesList[status.index]}">
					</td> 
					<td class="goods_info align-middle">
						<div class="align-middle info">
							<h5>${cartVO.goodsDto.goods_name}</h5>
							 - 가격 : <fmt:formatNumber pattern="###,###,###" type="number">${cartVO.goodsDto.goods_price}</fmt:formatNumber> 원<br>
							<h6 class="op_info">#옵션정보</h6>
							<c:forEach items="${cartVO.option_list}" var="goodsOptionDto">
								<input type="hidden" name="itemVOList[${status.index}].option_no_list" value="${goodsOptionDto.goods_option_no}">
								- ${goodsOptionDto.goods_option_title } : 
								${goodsOptionDto.goods_option_content}  
								(<fmt:formatNumber pattern="###,###,###" type="number"> ${goodsOptionDto.goods_option_price}</fmt:formatNumber>원)<br>
							</c:forEach>
						</div>
					</td>
					<td class="goods_quantity align-middle text-center">${cartVO.quantity} 개 </td>
					<td class="goods_price align-middle text-center"><fmt:formatNumber pattern="###,###,###" type="number">${cartVO.price}</fmt:formatNumber> 원</td>
					<td class="goods_total align-middle text-center">
						<div class="total_area align-middle text-center">
							<div class="total_area">
								<span class="item_pirce">
								<fmt:formatNumber pattern="###,###,###" type="number">
								${cartVO.price*cartVO.quantity}</fmt:formatNumber> 원</span>
								<input type="hidden" class="hItem_price" value="${cartVO.price*cartVO.quantity}">
							</div>
						</div>
					</td>
					<td class="align-middle text-center delete_btn_area">
						<button class="delete_btn btn btn-secondary">X</button>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="col-lg-8 submit_area">
		<div class="row justify-content-center submit_box">
			<div class="col-lg-12 total_title">
				<h3>총 결제 금액</h3>
			</div>
			<table class="table table-borderless total_table">
			<tbody>
				<tr>
					<th scope="row">배송비</th>
					<td><span class="delivery_price">1 원</span></td>
				</tr>
				<tr>
					<th scope="row">총 가격</th>
					<td><span class="ordering_price"> 원</span></td>
				</tr>
			</tbody>
		</table>
			<div class="col-lg-5 text-center"><input id="submit_btn" class="btn btn-secondary btn-block submit_btn" type="submit" value="주문하기"></div>
		</div>
	</div>
</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>