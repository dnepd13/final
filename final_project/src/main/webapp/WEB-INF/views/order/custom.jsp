<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 

<style>
	.custom-checkbox li {
		list-style: none;
		float: left;
		width: 120px;
	}	
</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script>

function customCheck(customCheck){
	var check = document.querySelector("customCheck");
	console.log(check);
	for(var i =0 ; i<check.length ; i++){
		if(check[i] !=customCheck){
			check[i].checked = false;
		}
	}
};

$(function(){

	// 배송비, 배송조건, 배송조건금액, 묶음 배송, 묶음 배송 조건
	// 보내야 할 정보
	
// 	@ 상품정보 (상품1개 + 옵션) 
// 	@ 배송지 
// 	@ 사용된 포인트
// 	@ 총 수량
// 	@ 총 금액(상품전체+배송비-포인트+부가세)
// 	@ 총 배송비

var g_total_price = orderingPriceUpdate();

////////// 총금액 업데이트
function orderingPriceUpdate(){
	var total_price = $(".total_price").data("total_price");
	
	// 총 상품금액 출력		
	if(total_price == 0){
		$(".ordering_btn").attr("disabled", true);
	}
	$(".ordering_price").html(addComma(String(total_price))+" 원");
	return total_price;
}

///////  포인트	
	$(".input_point").blur(function(){ // 사용포인트 입력 끝나면 updatePoint() 부르기
		updatePoint();
	});
	
	function getPoint(){ // 사용포인트 입력값 getPoint()로 반환
		return parseInt($(".input_point").val());
	}

	function updatePoint(){
		
		var point = getPoint();
		g_total_price = orderingPriceUpdate();
		var origin_point = $(".origin_point").data("origin_point");
		
		if(point > 0) {
			$(".ordering_price").html(addComma(String(g_total_price - point))+" 원");
			$(".origin_point").text(origin_point - point);
		} else {
			$(".input_point").val(0);
			$(".ordering_price").html(addComma(String(g_total_price - 0))+" 원");
			$(".origin_point").text(origin_point);
		}
	}


///////  콤마추가
function addComma(num){
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}

/////// 전송 시 데이터 업데이트
$(".form_send").submit(function(e){
	var jsonOrderVO = inputOrderInfo();
	$(".form_send").append($("<input type='hidden' name='jsonOrderVO' value='"+jsonOrderVO+"'>"));
});

// 결제 정보 담기
function inputOrderInfo(){
	var orderVO = new Object();
	var cartVOList = new Array();
	var total_price = orderingPriceUpdate();
	var total_quantity = 1;
	var orderDeliveryVO = new Object();
	var used_point = getPoint();
	
// 	var name = $(".order_addr_area").children(".name").val();
	var addr_post = $(".order_addr_area").children(".addr_post").val();
	var addr_basic = $(".order_addr_area").children(".addr_basic").val();
	var addr_extra = $(".order_addr_area").children(".addr_extra").val();
	var addr_status = $(".order_addr_area").children(".addr_status").val();
	
	orderDeliveryVO = {
// 		delivery_name : name,
		cart_info_addr_post : addr_post,
		cart_info_addr_basic : addr_basic,
		cart_info_addr_extra : addr_extra,
		cart_info_addr_status : addr_status
	};
	
	
	jsCartVOList.forEach(function(cartVO, i){
		if(cartVO != "") {
			cartVOList.push(cartVO);
			total_quantity += cartVO.quantity;
		}
	});
	
	jsonOrderVO = {
		cartVOList : cartVOList,
		orderDeliveryVO : orderDeliveryVO, // 구매자 배송지정보
		used_point : used_point,
		total_quantity : total_quantity,
		total_price : total_price - used_point,
// 		total_delivery_price : total_delivery_price,
		partner_user_id : "${member.member_id}" 
	};
	
	return JSON.stringify(jsonOrderVO);
}


});
</script>



<div class="ordering_area">
	<div class="order_addr_area">
		<!-- 회원정보에서 기본 배송지 가져오고, 새로 입력 누르면 ajax 수정 기능처럼 전환하여 데이터 입력 -->
		<div class="form-group">
		    <div class="custom-control custom-checkbox">
		    	<ul>
		    		<li>
						<input class="custom-control-input" name="customCheck" id="customCheck1" type="checkbox" checked onclick="customCheck()">
						<label class="custom-control-label" for="customCheck1">기본 배송지</label>
					</li>			
		   			<li>
				    	<input class="custom-control-input" name="customCheck" id="customCheck2" type="checkbox" onclick="customCheck()">
						<label class="custom-control-label" for="customCheck2">새로운 배송지</label>
					</li>
		   		</ul>
		    </div>
		</div>
		
		<table class="addr_table" border="1">
			<tr>
				<td>받는사람</td><td><input class="name" type="text" value="${member.member_name }"></td>
			</tr>
			<tr>
				<td>연락처</td><td><input type="text" name="" value="${member.member_phone }" placeholder=" '-' 없이 입력"></td>
			</tr>
			<tr>
				<td rowspan="2">
					주소
					<input class="addr_status" type="hidden" name="addr_status" value="${memberAddr.member_addr_status }">
				</td>
				<td><input class="addr_post" type="text" name="" value="${memberAddr.member_addr_post }"></td>
				<td><button>우편번호 찾기</button></td>
			</tr>
			<tr>
				<td><input class="addr_basic" type="text" name="" value="${memberAddr.member_addr_basic }"></td>
				<td><input class="addr_extra" type="text" name="" value="${memberAddr.member_addr_extra }"></td>
			</tr>
		</table>
	
	<hr>
		<h2>선택한 상품 목록</h2>
		<!-- 상품정보칸 -->
			상품이름 : ${customVO.custom_order_title}<br>
			상품가격 : <fmt:formatNumber pattern="###,###,###" type="number">${customVO.custom_order_price}</fmt:formatNumber> 원<br>
			<br>	
			수량 : 1 개 <br>
	</div>
	<!-- 토탈 -->
		<div class="total_area">
		총 가격 : 
			<span class="total_price" data-total_price="${customVO.custom_order_price}">
			<fmt:formatNumber pattern="###,###,###" type="number">
				${customVO.custom_order_price}
			</fmt:formatNumber></span>원
		</div>

	<hr>
	<div class="point_area">
		포인트 사용 가능 금액 : <span class="origin_point" data-origin_point="${memberPoint }">${memberPoint }</span> point<br>
		포인트 사용 : <input class="input_point" type="text" name="used_point" value="0"> <br>
	</div>
	주문 총 가격 : <span class="ordering_price"> 원</span>
	<hr>
	<button class="kakao">KakaoPay</button>
	<button class="credit" disabled>신용카드</button>
	<button class="deposit" disabled>무통장입금</button>
	<button class="account" disabled>계좌이체</button>
	<form class="form_send" action="${pageContext.request.contextPath}/pay/kakao/customConfirm" method="POST">
	<button id="ordering_btn">결제하기</button>
	</form>
</div>	
	<hr>

