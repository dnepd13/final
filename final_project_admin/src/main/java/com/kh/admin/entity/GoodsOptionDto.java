package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class GoodsOptionDto {
	private int goods_option_no,
					goods_no,
					goods_option_price,
					goods_option_stock;
	private String goods_option_title,
						goods_option_content,
						goods_option_status;
	
}
