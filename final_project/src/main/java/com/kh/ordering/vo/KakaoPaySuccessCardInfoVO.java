package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class KakaoPaySuccessCardInfoVO {
	private String purchase_corp, //매입카드사 한글명
	purchase_corp_code,//매입카드사 코드	
	issuer_corp,//	카드발급사 한글명
	issuer_corp_code,//	카드발급사 코드
	kakaopay_purchase_corp,//카카오페이 매입사명
	kakaopay_purchase_corp_code,//카카오페이 매입사코드
	kakaopay_issuer_corp,//	카카오페이 발급사명
	kakaopay_issuer_corp_code,//카카오페이 발급사코드
	bin,//	카드 BIN
	card_type,//	카드타입
	install_month,//	할부개월수
	approved_id,//	카드사 승인번호
	card_mid,//	카드사 가맹점번호
	interest_free_install,//	무이자할부 여부(Y/N)
	card_item_code;//	카드 상품 코드
}
