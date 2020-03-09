package com.kh.ordering.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderVO {
	private List<CartVO> cartVOList;
	private OrderDeliveryVO orderDeliveryVO;
	private int used_point;
	private int total_quantity;
	private int total_price;
	private int total_delivery_price;
	private String partner_user_id;
	
	private CustomOrderVO customOrderVO;
}
