package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CartInfoOpDto {
	private int cart_info_op_no;
	private int cart_info_goods_no;
	private int goods_option_no;
}
