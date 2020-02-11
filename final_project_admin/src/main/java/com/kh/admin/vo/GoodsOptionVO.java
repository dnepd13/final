package com.kh.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor 
public class GoodsOptionVO extends BaseVO{
	private int 
				goods_option_price,
				goods_option_stock;
	private String goods_option_title,
						goods_option_content,
						goods_option_status;
}
