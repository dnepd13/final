package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class GoodsDto {
	private int goods_no;
	private int seller_no;
	private String goods_name;
	private int goods_price;
	private int goods_discount_price;
	private String goods_discount_start;
	private String goods_discount_finish;
	private int goods_stock;
	private String goods_status;
	private String goods_content;
	private int category_no;
}
