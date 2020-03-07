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
          console.log(count);
          $("#submit_btn").attr("disabled", false);
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
	var div = $("<div class='div input-group option_box'></div>");
	div.appendTo(".optionArea");
    var input_title = $("<input class='form-control' placeholder='옵션그룹이름' required>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_title");
	
	var input_content = $("<input class='form-control' placeholder='세부옵션이름' required>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_content");
	
	var input_price = $("<input class='form-control' placeholder='가격' required>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_price");
	
	var input_stock = $("<input class='form-control' placeholder='수량' required>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_stock");
	
	var input_status = $("<select class='form-control' required>")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_status")
	  .append("<option value=''>판매여부</option>")
	  .append("<option value='Y'>Y</option>")
	  .append("<option value='N'>N</option>");
	
	// 삭제 버튼
	var deletebtn = $("<button class='delbtn btn btn-secondary btn-sm'>삭제</button>");
	deletebtn.click(function(e){
		e.preventDefault();
		$(this).parents(".option_box").remove();
		count--;
		if(count<1){
			$("#submit_btn").attr("disabled", true);
			$(".submit_comment").show();
		}
	});
	
	var li = $("<li class='input-group'>");
	li.append(input_title)
	  .append(input_content)
	  .append(input_price)
	  .append(input_stock)
	  .append(input_status)
	  .append(deletebtn)
	  .appendTo(div);
	
}