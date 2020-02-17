package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class KakaoPaySuccessReadyVO {
	private String cid, //가맹점 코드
	tid, //결제 고유번호
	partner_order_id, //가맹점 주문번호
	partner_user_id, //가맹점 회원 id
	pg_token; //결제승인 요청을 인증하는 토큰
}
