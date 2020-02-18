package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CartInfoDto {
	private int cart_info_no;
	private int member_no;
	private int non_no;
	private String delivery_name;
	private String cart_info_addr_post;
	private String cart_info_addr_basic;
	private String cart_info_addr_extra;
	private String cart_info_addr_status;
	private int used_point;
	private int total_quantity;
	private int total_price;
	private int total_delivery_price;
	private String partner_order_id;
	private String cart_info_status;
}
