package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class KakaoPaySuccessReturnVO {
	private String aid,//Request 고유 번호	
	tid,//	결제 고유 번호
	cid,//	가맹점 코드
	sid;//subscription id. 정기(배치)결제 CID로 결제요청한 경우 발급


private String partner_order_id,//가맹점 주문번호
		partner_user_id,//	가맹점 회원 id
		payment_method_type,//결제 수단. CARD, MONEY 중 하나
		item_name,//상품 이름. 최대 100자
		item_code,//	상품 코드. 최대 100자
		created_at,//결제 준비 요청 시각
		approved_at,//결제 승인 시각
		payload;//	Request로 전달한 값

		private int quantity;//	상품 수량
		
		private KakaoPayAmountVO amount;
		private KakaoPaySuccessCardInfoVO card_info;
}
