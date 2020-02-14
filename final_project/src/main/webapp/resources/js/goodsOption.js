var count = 0;
 $(function() {
        var index = 0;
        
        $(".delivery_price").hide(); 
		$(".delivery_op_price").hide();
        
        // 옵션 추가
        $(".addOptionBtn").click(function(e) {
          e.preventDefault();
          createOption(index++);
          count++;
          $(".submit_btn").attr("disabled", false);
          $(".submit_comment").hide();
        });
        
        
        $(".delivery_option").change(function(){
        	switch ($(this).val()) {
			case '무료': 
				$(".delivery_price").hide(); 
				$(".delivery_op_price").hide();
				break;
			case '유료': 
				$(".delivery_price").show();
				$(".delivery_op_price").hide();
				break;
			case '조건부무료': 
				$(".delivery_price").show();
				$(".delivery_op_price").show();
				break;

			default:
				$(".delivery_price").hide(); 
				$(".delivery_op_price").hide();
				break;
			}
        });
  });

function createOption(index) {
	var div = $("<div class='div'></div>");
	div.appendTo(".optionArea");
	
    var input_title = $("<input required>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_title");
	
	var input_content = $("<input required>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_content");
	
	var input_price = $("<input required>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_price");
	
	var input_stock = $("<input required>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_stock");
	
	var input_status = $("<select required>")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_status")
	  .append("<option value='Y'>Y</option>")
	  .append("<option value='N'>N</option>");
	
	// 삭제 버튼
	var deletebtn = $("<button class='delbtn'>삭제</button>");
	deletebtn.click(function(e){
		e.preventDefault();
		$(this).parent(div).remove();
		count--;
		if(count<1){
			$(".submit_btn").attr("disabled",true);
			$(".submit_comment").show();
		}
	});
	
	var li = $("<li>");
	li.append(input_title)
	  .append(input_content)
	  .append(input_price)
	  .append(input_stock)
	  .append(input_status)
	  .append(deletebtn)
	  .appendTo(div);
	
}