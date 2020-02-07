package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// custom order 관련 테이블의 통합 조회를 위한 VO
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CustomOrderVO {

//	주문제작
	private int custom_order_no; // 통합문서 고유번호
	private String custom_order_title;	// 제목
	private String custom_order_content;	// 상세내용
	private String custom_order_date;	// 작성날짜
	private int custom_order_price;	// 희망가격
	private String custom_order_hopedate;	// 희망날짜
	private String custom_order_status;	// 진행상황: 진행 중, 채택완료
	private String custom_order_type;	// 구분: 요청서, 견적서
	
//	판매자 견적서 관리
	private int seller_custom_order_no;
	private int seller_no; 
	
//	회원 견적서 관리
	private int member_custom_order_no; // 요청서관리 고유번호
	private int member_no; // 회원번호

// 회원 정보
	private String member_id;
	private String member_name;
// 판매자 정보
	private String seller_id;
	private String seller_name;
}
