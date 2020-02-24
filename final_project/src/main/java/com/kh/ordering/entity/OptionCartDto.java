package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OptionCartDto {
	private int option_cart_no;
	private int goods_cart_no;
	private int goods_option_no;
}
