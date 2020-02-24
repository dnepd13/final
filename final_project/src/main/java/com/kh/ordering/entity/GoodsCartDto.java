package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class GoodsCartDto {
	private int goods_cart_no;
	private int member_no;
	private int goods_no;
	private int goods_cart_quantity;
	private int goods_cart_price;
}
