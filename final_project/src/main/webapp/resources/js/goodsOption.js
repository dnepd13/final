 $(function() {
        var index = 0;

        $(".addOptionBtn").click(function(e) {
          e.preventDefault();
          createOption(index++);
        });
      });

      function createOption(index) {
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

        var deletebtn = $("<button class='delbtn'>삭제</button>");

        var li = $("<li>");
        li.append(input_title)
          .append(input_content)
          .append(input_price)
          .append(input_stock)
          .append(input_status)
          .append(deletebtn)
          .appendTo(".optionArea");
}