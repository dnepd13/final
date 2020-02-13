package com.kh.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class GoodsCategoryVO {
		private int goods_no,//
						seller_no,//
						goods_price,//
						goods_discount_price,//
						goods_stock,//
						category_no;//
		private String goods_name,//
						goods_discount_start,//
						goods_discount_finish,//
						goods_status,//
						goods_content,//
						category_large,//
						category_middle,//
						category_small,//
						seller_id,//
 						seller_name,//
 						seller_email,//
 						seller_phone,//
 						seller_birth,//주민등록 또는 사업자등록
 						seller_addr_post,//
 						seller_addr_basic,//
 						seller_addr_extra,//
 						seller_store_name,//
 						seller_store_phone,//
 						seller_store_fax,//
 						seller_grade;//
}
