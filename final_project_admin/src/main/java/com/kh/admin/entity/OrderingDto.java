package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class OrderingDto {
	private int ordering_no,
					member,
					non,
					quantity,
					total_amount,
					tax_free_amount,
					vat_amount,
					install_month,
					used_point;
	
	private String cid,
						tid,
						aid,
						partner_order_id,
						partner_user_id,
						item_name,
						ordering_status,
						process_time;
					
}
