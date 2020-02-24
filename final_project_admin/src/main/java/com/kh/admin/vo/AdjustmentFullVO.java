package com.kh.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class AdjustmentFullVO {
	private String partner_order_id,
						ordering_status,
						process_time,
						member_id,
						goods_name,
						seller_id,
						seller_name,
						seller_email,
						seller_phone,
						seller_store_name,
						seller_store_phone,
						seller_bank_code,
						seller_bank_account,
						seller_bank_username;
	private int total_delivery_price,
					cart_info_goods_quantity,
					cart_info_goods_price,
					seller_no,
					total_amount,
					total_cal_price,
					fee,
					rate,
					adjustment_price;
					
}
