package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CartDetailsVO {
	private int member_no;
	private int cart_info_no;
	private String cart_info_status;
	
	// 상품정보
	private int cart_info_goods_no;
	private int cart_info_goods_quantity;
	private int cart_info_goods_price;
	
	private int goods_no;
	private String goods_name;
	private int goods_price;
	private int category_no;
	
	// 옵션정보
	private int goods_option_no;
	private String goods_option_title;
	private String goods_option_content;
	private int goods_option_price;
	
	// 구매확정
	private String cart_ok_date;
	private String cart_ok_status;
}
