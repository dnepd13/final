package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DeliveryVO {
	private int delivery_no;
	private String delivery_agree;
	private String delivery_set_agree;
	private String delivery_company;
	private int delivery_price;
	private String delivery_option;
	private int delivery_set_op_price;
	private int delivery_return_price;
	private int delivery_op_price;
	private int goods_no;
	private int seller_no;
}
