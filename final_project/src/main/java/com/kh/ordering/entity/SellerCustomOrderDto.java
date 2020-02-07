package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class SellerCustomOrderDto {
	private int seller_custom_order_no;
	private int custom_order_no;
	private int seller_no;
}
