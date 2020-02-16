package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class KakaoPayReadyVO implements PayReadyVO{
	private String 
	partner_order_id, 
	partner_user_id, 
	item_name;

	private int 		
		quantity,
		total_amount,
		vat_amount,
		tax_free_amount;
}	
