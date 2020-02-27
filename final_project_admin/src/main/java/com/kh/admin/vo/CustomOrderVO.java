package com.kh.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CustomOrderVO {
	private int custom_order_no,
					custom_order_price;
	
	private String custom_order_title,
						custom_order_content,
						custom_order_date,
						custom_order_hopedate,
						custom_order_status,
						custom_order_type,
						member_id,
						seller_id,
						category_large,
						category_middle,
						category_small;
}
