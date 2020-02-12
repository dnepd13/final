function loadJQuery() {
    var oScript = document.createElement("script");
    oScript.type = "text/javascript";
    oScript.charset = "utf-8";		  
    oScript.src = "https://code.jquery.com/jquery-3.4.1.min.js";	
    document.getElementsByTagName("head")[0].appendChild(oScript);
}

$(function(){
	var goodsOptionVOList = JSON.parse('${jsonGoodsOptionVOList}');
	var goodsVO = JSON.parse('${jsonGoodsVO}');
	var VOindex = 0;
	
	
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
			
			// div에 상품이름 추가
			var hidden_goods_name = $("<input type='hidden' name='itemVOList["+VOindex+"].goods_name' value='"+goodsVO.goods_name+"'>");
			div.append(hidden_goods_name);
			
			// div에 가격 추가
			var hidden_price = $("<input type='hidden' name='itemVOList["+VOindex+"].price' value='"+price+"'>");
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
				hidden_price.val(price);
			});
			
			// - 버튼
			minus.click(function(e){
				e.preventDefault();
				var qtt = $(this).siblings(".quantity").val();
				if(qtt>0) {
					price = total_price * (parseInt(qtt)-1);
					$(this).siblings(".quantity").val(parseInt(qtt)-1);
					span.html(addComma(price) + "원");
					hidden_price.val(price);
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
					hidden_price.val(price);
				}
			});
			
			// X 버튼
			delete_btn.click(function(e){
				e.preventDefault();
				$(this).parent(".total_price_area").remove();
				VOindex--;
			});
			
			// 리셋
			$(".options").val("");
			
			// VOindex++
			VOindex++;
		}
	});
	
	function addComma(num){
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
}); 