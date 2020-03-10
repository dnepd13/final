<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	.addr_table{
		border-top: 2px solid #171717;
		border-bottom: 1px solid #171717;
	}
	.addr_status {
		width: 250px;
		height: 30px;
		padding: 0px 12px;
	}
	.addr_table > tbody > tr > th {
	text-align: center;
	}
	.addr_table > tbody > tr > td {
		width: 75%;
		padding: 8px;
	}
	
	.col-lg-8 {
		margin: 25px 0px;
	}
	
	.cart_table {
		border-top: 2px solid #171717;
		border-bottom: 1px solid #171717;
	}
	.cart_table_title {
		border-bottom: 1px solid #171717;
	}
	
	.items_area {
		border-bottom: 1px solid #171717;
	}
		
	.goods_image {
		width: 10%;
		height: 100%;
	}	
	.goods_image > img {
		width: 100%;
		height: auto;
	}	
	.goods_info {
		width: 35%;
	}
	
	.info {
		padding-left: 10px;
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
	
	.table > tbody > tr > td > input {
		padding-left: 20px;
		border: none;
		background-color: #F2F2F2;
		width: 250px;
		height: 30px;
	}
	
	#ordering_btn {
		height: 40px;
		font-size: 1rem;
	}
	
	.payment {
		border: 1px solid gray;
		display: inline-block;
		margin: 0 3px;
		padding: 10px;
		width: 7rem;
		text-align: center;
	}
	.kakaoPay:focus {
		background-color: rgb(255, 235, 0);
	}
	
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

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

// 주소 새로 입력하기
	$(".addr_status").change(function(){

		if($(this).val()=='새로운주소'){
			$(".name").val("");
			$(".addr_post").val("");
			$(".addr_basic").val("");
			$(".addr_extra").val("");
		}
		else {
			$(".name").val("${member.member_name }");
			$(".addr_post").val("${memberAddr.member_addr_post }");
			$(".addr_basic").val("${memberAddr.member_addr_basic }");
			$(".addr_extra").val("${memberAddr.member_addr_extra }");
		}
		
	});

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
		if($(this).val() < ${memberPoint}){
			updatePoint();
		}
		else{
			$(this).val(${memberPoint})
			updatePoint();
		}
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
	var customOrderVO = new Object();
	var total_price = orderingPriceUpdate();
	var total_quantity = 1;
	var orderDeliveryVO = new Object(); // 받는 사람+주소정보
	var used_point = getPoint(); // 사용된 포인트
	
// 	var name = $(".order_addr_area").children(".name").val();
// 	var addr_post = $(".order_addr_area").children(".addr_post").val();
// 	var addr_basic = $(".order_addr_area").children(".addr_basic").val();
// 	var addr_extra = $(".order_addr_area").children(".addr_extra").val();
// 	var addr_status = $(".order_addr_area").children(".addr_status").val();
	var name = $("#addr_name").val();
	var addr_post = $("#sample6_postcode").val();
	var addr_basic = $("#sample6_address").val();
	var addr_extra = $("#sample6_detailAddress").val();
	var addr_status = $("#addr_status").val();

	orderDeliveryVO = {
		delivery_name : name,
		cart_info_addr_post : addr_post,
		cart_info_addr_basic : addr_basic,
		cart_info_addr_extra : addr_extra,
		cart_info_addr_status : addr_status
	};
	
	var custom_order_no = "${customVO.custom_order_no}";
	var custom_order_status = "${customVO.custom_order_status}";
	var seller_custom_order_no = "${customVO.seller_custom_order_no}";
	var seller_no = "${customVO.seller_no}";
	var seller_id ="${customVO.seller_id}";
	var custom_order_title = $(".custom_order_title").text();
	
	customOrderVO = {
		custom_order_no : custom_order_no,
		custom_order_status : custom_order_status,
		seller_custom_order_no : seller_custom_order_no,
		seller_id : seller_id,
		seller_no : seller_no,
		custom_order_title : custom_order_title
	};
	
	jsonOrderVO = {
		customOrderVO : customOrderVO,
		orderDeliveryVO : orderDeliveryVO,
		used_point : used_point,
		total_quantity : total_quantity,
		total_price : total_price - used_point,
// 		total_delivery_price : total_delivery_price,
		partner_user_id : "${member.member_id}" 
	};
	
	return JSON.stringify(jsonOrderVO);
}

	
});
	
	function kakaoPay(){
		console.log($("#ordering_btn").text());
		$("#ordering_btn").prop("disabled", false);
	};

</script>

<div class="row-empty-40"></div>

<form class="form_send" action="${pageContext.request.contextPath}/pay/kakao/customPay" method="POST">

<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 order_addr_area justify-content-center">
		<h3>배송지</h3>
		<table class="table table-borderless addr_table">
			<tbody>
				<!-- 회원정보에서 기본 배송지 가져오고, 새로 입력 누르면 ajax 수정 기능처럼 전환하여 데이터 입력 -->
				<tr>
					<th scope="row"></th>
					<td><select id="addr_status" class="addr_status form-control" name="addr_status">
							<option value="기본주소">기본주소</option>
							<option value="새로운주소">새로운주소</option>
							</select>
					</td>
				</tr>
				<tr>
					<th scope="row">받는사람</th>
					<td><input class="name" type="text" name="name" id="addr_name" value="${member.member_name }" required></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input class="member_phone" type="text" name="member_phone" value="${member.member_phone }" placeholder=" '-' 없이 입력"></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td><input class="addr_post" type="text" name="addr_post"  id="sample6_postcode" placeholder="우편번호" value="${memberAddr.member_addr_post }" required>
							<button class="find_btn btn btn-secondary" type="button" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
					</td>
				</tr>
				<tr>
					<th scope="row">기본주소</th>
					<td><input class="addr_basic" type="text" name="addr_basic" id="sample6_address" placeholder="주소" value="${memberAddr.member_addr_basic }" required></td>
				</tr>
				<tr>
					<th scope="row">상세주소</th>
					<td><input class="addr_extra" type="text" name="addr_extra"  id="sample6_detailAddress" placeholder="상세주소" value="${memberAddr.member_addr_extra }" required>
							<input type="text" id="sample6_extraAddress" class="" placeholder="참고항목">
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<!-- 주문할 상품정보 -->
	<div class="col-lg-8">
		<div class="cart_title">
			<h3>주문 상품</h3>
		</div>
		<table class="table table-borderless cart_table">
			<tr class="cart_table_title">
				<th colspan="2" scope="col" class="align-middle text-center" style="width: 33%">상품정보</th>
				<th scope="col" class="align-middle text-center" style="width: 13%">수량</th>
				<th scope="col" class="align-middle text-center" style="width: 20%">가격</th>
				<th scope="col" class="align-middle text-center" style="width: 20%">총 가격</th>
				<th scope="col" class="align-middle text-center" style="width: 13%">-</th>
			</tr>
			<tr class="items_area">
				<td class="goods_image align-middle" style="width: 20%">
	<%-- 				<img src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${filesList[status.index]}"> --%>
				</td>
				<td class="goods_info align-middle">
					<div class="align-middle info">
						<h5 class="custom_order_title">${customVO.custom_order_title}</h5>
						- 가격 : <fmt:formatNumber pattern="###,###,###" type="number">${customVO.custom_order_price}</fmt:formatNumber> 원<br>
					</div>
				</td>
				<td class="goods_quantity align-middle text-center">1 개</td>
				<td class="goods_price align-middle text-center custom_order_price"><fmt:formatNumber pattern="###,###,###" type="number">${customVO.custom_order_price}</fmt:formatNumber> 원</td>
				<td class="goods_total align-middle text-center">
					<div class="total_area align-middle text-center">
						<span class="item_pirce total_price" data-total_price="${customVO.custom_order_price}">
							<fmt:formatNumber pattern="###,###,###" type="number">
								${customVO.custom_order_price}</fmt:formatNumber> 원</span>
						<input type="hidden" class="custom_order_price" value="${customVO.custom_order_price}">
					</div>
				</td>
			</tr>
		</table>
	</div>

	<!-- 최종 결제금액 (포인트 합산) -->
	<div class="col-lg-8">
		<div>
			<h3>최종결제금액</h3>
		</div>
		<table class="table table-borderless total_table">
			<tbody>
				<tr>
					<th scope="row">포인트 사용 가능 금액</th>
					<td><span class="max_point origin_point" data-origin_point="${memberPoint }">
								<fmt:formatNumber pattern="###,###,###" type="number">${memberPoint }</fmt:formatNumber>
							</span> 포인트
					</td>
				</tr>
				<tr>
					<th scope="row">사용 포인트</th>
					<td><input class="input_point" type="text" name="used_point" value="0"></td>
				</tr>
				<tr>
					<th scope="row">배송비</th>
					<td><span class="delivery_price">0 원</span></td>
				</tr>
				<tr>
					<th scope="row">총 가격</th>
					<td><span class="ordering_price"> 원</span></td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="col-lg-8">
		<div>
			<h3>결제방법</h3>
		</div>
		<table class="table table-borderless total_table">
			<tr>
				<th></th>
				<td><span>
							<a href="javascript:void(0);" class="kakaoPay payment" onclick="kakaoPay(); return false;">KakaoPay</a>
						</span>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="col-lg-5">
		<button id="ordering_btn" class="btn btn-secondary btn-block" disabled>결제하기</button>
	</div>
	
</div>	

</form>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>