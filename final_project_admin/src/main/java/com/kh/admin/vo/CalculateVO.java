package com.kh.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CalculateVO {
	private String cart_info_status,
						partner_order_id,
						process_time,
						goods_name,
						seller_id,
						seller_name,
						seller_email,
						seller_phone,
						seller_store_name,
						seller_bank_account,
						seller_bank_code,
						seller_bank_username;
						
						
	private int goods_no,
					cart_info_goods_price,
					cart_info_goods_quantity,
					seller_no,
					
					total;
					
					
}
