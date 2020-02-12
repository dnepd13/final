<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/goodsInfo.js"></script> --%>
<script>

$(function(){
	var goodsOptionVOList = JSON.parse('${jsonGoodsOptionVOList}');
	var goodsVO = JSON.parse('${jsonGoodsVO}');
	var VOindex = 0;
	var final_price = 0;
	var final_qtt = 0;
	
	// 옵션 선택 이벤트
	$(".options").change(function(){
		var selectedAll = true;
		$(".options").each(function(){
			if(!$(this).val()){
				selectedAll = false;
				return false;
			}
		});
		
		// 옵션 전체 선택했을 때
		if(selectedAll){
			var price = goodsVO.goods_price;
			var title;
			var content;
			var option_price;
			var option_no_list = new Array();
			var qtty;
			
			var div = $("<div class='total_price_area'></div>"); // 선택 상품+옵션 그룹div
			
			div.append($("<h4>선택한 옵션</h4>"));
			
			// 옵션 선택 정보 저장 (옵션번호리스트, 가격합계)
			$(".options").each(function(i){
				var no = $(this).val();
				var arr = goodsOptionVOList[i].goodsOptionList;
				var index = arr.findIndex(dto => dto.goods_option_no == no);
				price += arr[index].goods_option_price;
				title = goodsOptionVOList[i].goods_option_title;
				content = arr[index].goods_option_content;
				option_price = arr[index].goods_option_price;
				
				// div에 옵션별 정보 추가
				var option_info = $("<h5>" + title + " : " + content + "(" + addComma(option_price) + "원)" +"</h5>");
				div.append(option_info);
				
				// div에 no 추가
				var option_no = $("<input type='hidden' name='itemVOList["+VOindex+"].option_no_list' value='"+no+"'>");
				div.append(option_no);
			});
			
			
			
			// div에 나머지 기능 추가
			var goods_name = $("<h3>" + goodsVO.goods_name + "</h3>");
			var span = $("<span class='total_price'>"+ addComma(price) + "원</span>");
			var plus = $("<a class='plus_btn' href='#'> + </a>");
			var minus = $("<a class='minus_btn' href='#'> - </a>");
			var delete_btn = $("<a class='delete' href='#'>X</a>");
			
			// div에 수량 추가
			var quantity = $("<input class='quantity' name='itemVOList["+VOindex+"].quantity' type='text' value='1'>");
			
			// div에 상품번호 추가
			var hidden_goods_no = $("<input type='hidden' name='itemVOList["+VOindex+"].goods_no' value='"+goodsVO.goods_no+"'>");
			div.append(hidden_goods_no);
			
			// div에 가격 추가
			var hidden_price = $("<input class='hPrice' type='hidden' name='itemVOList["+VOindex+"].price' value='"+price+"'>");
			div.append(hidden_price);
			
			$(".selected_area").append(div);
			div.append(goods_name).append(span).append(quantity).append(plus).append(minus)
			.append(delete_btn);
			
			// 상품+옵션 가격
			var total_price = price;
			
			
			// + 버튼
			plus.click(function(e){
				e.preventDefault();
				var qtt = $(this).siblings(".quantity").val();
				price = total_price * (parseInt(qtt)+1);
				$(this).siblings(".quantity").val(parseInt(qtt)+1);
				span.html(addComma(price) + "원");
				setFinalArea();
			});
			
			// - 버튼
			minus.click(function(e){
				e.preventDefault();
				var qtt = $(this).siblings(".quantity").val();
				if(qtt>0) {
					price = total_price * (parseInt(qtt)-1);
					$(this).siblings(".quantity").val(parseInt(qtt)-1);
					span.html(addComma(price) + "원");
					setFinalArea();
				}
			});
			
			// 수량 수정
			quantity.blur(function(){ 
				var qtt = $(this).val();
				if(qtt>=0) {
					qtty = parseInt(qtt);
					price = total_price * (parseInt(qtt));
					$(this).siblings(".quantity").val(parseInt(qtt));
					span.html(addComma(price) + "원");
					setFinalArea();
				}
			});
			
			// X 버튼
			delete_btn.click(function(e){
				e.preventDefault();
				$(this).parent(".total_price_area").remove();
				VOindex--;
				setFinalArea();
			});
			
			// 리셋
			$(".options").val("");
			
			// VOindex++
			VOindex++;
			
			// 총 상품금액(수량) 업데이트
			setFinalArea();
		}
	});
	
	// 총 상품금액(수량) 업데이트
	function setFinalArea(){
		var fPrice = 0;
		var fQuantity = 0;
		$(".total_price_area").each(function(){
			fQuantity += parseInt($(this).children(".quantity").val());
			fPrice += $(this).children(".hPrice").val() * parseInt($(this).children(".quantity").val());
		});
		
		console.log(fPrice);
		console.log(fQuantity);
		
		$(".final_price").html(addComma(fPrice) + "원");
		$(".final_qtt").html(" ("+fQuantity+")개");
	}
	
	function addComma(num){
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
}); 
</script>

<h1>상품 상세 페이지</h1>

<p>상품 상세 내용(goods_content)</p>
<p>${goodsVO.goods_content}</p>
<hr>
<br>

<span>
	<c:choose>
		<c:when test="${member_id !=null }">
			<a href="${pageContext.request.contextPath}/member/customOrder?seller_no=93">1:1 요청서</a>
		</c:when>
		<c:otherwise>
			<a href="${pageContext.request.contextPath}/member/login">1:1 요청서</a>
		</c:otherwise>
	</c:choose>
</span>

<hr>
<form action="../order/order" method="POST">
<!-- 옵션 선택하는 부분----------------------------------------->
<h1>옵션선택</h1>
<div class="option_area">
	<c:forEach items="${goodsOptionVOList}" var="goodsOptionVO" varStatus="status">
		<span>${goodsOptionVO.goods_option_title} : </span>
		<select class=options>
			<option value="">선택</option>
			<c:forEach items="${goodsOptionVO.goodsOptionList}" var="goodsOptionDto">
				<option value="${goodsOptionDto.goods_option_no}">${goodsOptionDto.goods_option_content}(${goodsOptionDto.goods_option_price})</option>			
			</c:forEach>
		</select>
		<br>
	</c:forEach>
</div>
<!-- --------------------------------------------------- -->
<hr>
<div class="selected_area">
	<h1>상품+옵션 선택 내용</h1>
</div>

<input class="submit" type="submit" value="주문하기">
</form>
<hr>
<div class="total_area">
<h1>총 상품금액(수량)</h1>
<span class="final_price">0원 </span><span class="final_qtt">(0개)</span>
</div>
<hr>
<p>상품 문의</p>
<hr>

<p>리뷰</p>
<hr>