package com.kh.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class FinalCalculateVO {
	private String seller_bank_account,
						seller_bank_code,
						seller_bank_username,
						seller_email,
						seller_id,
						seller_name,
						seller_phone,
						seller_store_name;
	private int total,
					rate;
}
