package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 주문내역 목록의 출력을 위한 VO
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CartInfoVO {
	
	private int ordering_no;
	private String item_name;
	private String process_time;
	private int total_amount;
	private int vat_amount;
	
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
	
	private int cart_info_goods_no;
	private int cart_info_goods_quantity;
	private int cart_info_goods_price;
	private int goods_no;
	
	private String goods_name;
	
	private String cart_ok_date;
	private String cart_ok_status;
	
	private int seller_no;
	private String seller_id;
}