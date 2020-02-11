package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@NoArgsConstructor @AllArgsConstructor @Builder
public class SellerDto {
	private int seller_no;
	private String seller_id, seller_pw, seller_name,  seller_email, seller_phone, 
					seller_birth, seller_addr_post, seller_addr_basic, seller_addr_extra, 
					seller_store_name, seller_store_phone, seller_store_fax,
					seller_join_date, seller_last_login, seller_agree_date, seller_grade, 
					seller_cid, seller_bank_code, seller_bank_account, seller_bank_username,seller_bank_birth;

		
	
}
