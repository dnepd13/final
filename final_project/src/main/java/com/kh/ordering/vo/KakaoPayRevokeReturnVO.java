package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class KakaoPayRevokeReturnVO {
				private String aid,	
						tid,
						cid,
						status,
						partner_order_id,
						partner_user_id, 
						payment_method_type,
						item_name,
						item_code,
						created_at,
						approved_at,
						canceled_at,
						payload;
						private int quantity;
						private KakaoPayAmountVO amount;
						private KakaoPayAmountVO canceled_amount ;
						private KakaoPayAmountVO cancel_available_amount ;
}
