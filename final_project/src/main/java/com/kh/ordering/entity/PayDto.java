package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PayDto {
	private int ordering_no, 
	quantity, 
	total_amount,
	member,
	non,
	used_point,
	tax_free_amount,
	vat_amount,
	install_month;
	private String tid, 
			cid, 
			process_time, 
			item_name,
			partner_order_id, 
			partner_user_id, 
			ordering_status,
			aid;
}
