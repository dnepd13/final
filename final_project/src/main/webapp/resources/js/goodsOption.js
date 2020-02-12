 $(function() {
        var index = 0;

        // 옵션 추가
        $(".addOptionBtn").click(function(e) {
          e.preventDefault();
          createOption(index++);
        });
        
        
  });

function createOption(index) {
	var div = $("<div class='div'></div>");
	div.appendTo(".optionArea");
	
    var input_title = $("<input>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_title");
	
	var input_content = $("<input>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_content");
	
	var input_price = $("<input>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_price");
	
	var input_stock = $("<input>")
	  .attr("type", "text")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_stock");
	
	var input_status = $("<select>")
	  .attr("name", "goodsOptionList[" + index + "].goods_option_status")
	  .append("<option value='Y'>Y</option>")
	  .append("<option value='N'>N</option>");
	
	// 삭제 버튼
	var deletebtn = $("<button class='delbtn'>삭제</button>");
	deletebtn.click(function(e){
		e.preventDefault();
		$(this).parent(div).remove();
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