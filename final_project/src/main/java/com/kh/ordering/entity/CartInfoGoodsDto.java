package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartInfoGoodsDto {
	private int cart_info_goods_no;
	private int cart_info_no;
	private int goods_no;
	private int cart_info_goods_quantity;
	private int cart_info_goods_price;
}
