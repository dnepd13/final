<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function(){
		var goodsOptionVOList = JSON.parse('${jsonGoodsOptionVOList}');
		var goodsVO = JSON.parse('${jsonGoodsVO}');
		
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
				$(".options").each(function(i){
					var no = $(this).val();
					var arr = goodsOptionVOList[i].goodsOptionList;
					var index = arr.findIndex(dto => dto.goods_option_no == no);
					price += arr[index].goods_option_price;
				});
				var div = $("<div class='total_price_area'></div>");
				var span = $("<span class='total_price'>"+ addComma(price) + "원</span>");
				
				var quantity = $("<input class='quantity' type='text' name='quantity' value='1'>");
				var plus = $("<a class='plus_btn' href='#'> + </a>");
				var minus = $("<a class='minus_btn' href='#'> - </a>");
				var delete_btn = $("<a class='delete' href='#'>X</a>");
				$(".selected_area").append(div);
				div.append(span).append(quantity).append(plus).append(minus).append(delete_btn);
				
				// 상품+옵션 가격
				var total_price = price;
				
				// + 버튼
				plus.click(function(e){
					e.preventDefault();
					var qtt = $(this).siblings(".quantity").val();
					price = total_price * (parseInt(qtt)+1);
					console.log(price);
					$(this).siblings(".quantity").val(parseInt(qtt)+1);
					span.html(addComma(price) + "원");
				});
				
				// - 버튼
				minus.click(function(e){
					e.preventDefault();
					var qtt = $(this).siblings(".quantity").val();
					if(qtt>0) {
						price = total_price * (parseInt(qtt)-1);
						$(this).siblings(".quantity").val(parseInt(qtt)-1);
						span.html(addComma(price) + "원");
					}
				});
				
				// X 버튼
				delete_btn.click(function(e){
					e.preventDefault();
					$(this).parent(".total_price_area").remove();
				});
				
				// 리셋
				$(".options").val("");
			}
		});
		
		
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

<p>상품 옵션 (goodsOptionList)</p>
<p>${goodsVO.goodsOptionList}</p>

<p><a href="${pageContext.request.contextPath}/member/customOrder?seller_no=93">1:1 요청서</a></p>

<hr>
<form>
<!-- 옵션 선택하는 부분--------------------------------------- -->
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


<input type="submit" value="주문하기">
</form>
<hr>
<p>상품 문의</p>
<hr>

<p>리뷰</p>
<hr>