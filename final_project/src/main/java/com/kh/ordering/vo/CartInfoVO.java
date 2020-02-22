package com.kh.ordering.vo;

import com.kh.ordering.entity.CartInfoDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CartInfoVO {
	private String partner_order_id;
	private int member_no;
	private int non_no;
	private String cart_info_addr_post;
	private String cart_info_addr_basic;
	private String cart_info_addr_extra;
	private String cart_info_addr_status;
	private int total_quantity;
	private int total_delivery_price;
	private int total_price;
	private int used_point;
	private String cart_info_status;
	private String delivery_name;
	
	private int cart_info_goods_no;
	private int cart_info_goods_quantity;
	private int cart_info_goods_price;
	
	private int goods_no;
	private String goods_name;
}
