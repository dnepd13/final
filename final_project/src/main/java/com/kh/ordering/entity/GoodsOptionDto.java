package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class GoodsOptionDto {
	private int goods_option_no;
	private int goods_no;
	private String goods_option_title;
	private String goods_option_content;
	private int goods_option_price;
	private int goods_option_stock;
	private String goods_option_status;
}
