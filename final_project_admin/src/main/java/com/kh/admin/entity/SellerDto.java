package com.kh.admin.entity;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.Data;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class SellerDto {
	 private int seller_no;
	 private String seller_id,
	 						seller_pw,
	 						seller_name,
	 						seller_email,
	 						seller_phone,
	 						seller_birth,//주민등록 또는 사업자등록
	 						seller_addr_post,
	 						seller_addr_basic,
	 						seller_addr_extra,
	 						seller_store_name,
	 						seller_store_phone,
	 						seller_store_fax,
	 						seller_join_date,
	 						seller_last_login,
	 						seller_agree_date,
	 						seller_cid,
	 						seller_bank_code,
	 						seller_bank_account,
	 						seller_bank_username,
	 						seller_bank_birth,
	 						seller_grade;
}
