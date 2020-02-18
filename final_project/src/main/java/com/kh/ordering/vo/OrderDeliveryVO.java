package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OrderDeliveryVO {
	private String delivery_name;
	private String cart_info_addr_post;
	private String cart_info_addr_basic;
	private String cart_info_addr_extra;
	private String cart_info_addr_status;
}
