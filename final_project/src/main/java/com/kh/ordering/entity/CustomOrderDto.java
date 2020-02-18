package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 요청서, 견적서 Dto

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CustomOrderDto {
	private int custom_order_no;
	private String custom_order_title;	// 제목
	private String custom_order_content;	// 상세내용
	private String custom_order_date;	// 작성날짜
	private int custom_order_price;	// 희망가격
	private String custom_order_hopedate;	// 희망날짜
	private String custom_order_status;	// 진행상황: 진행 중, 채택완료
	private String custom_order_type;	// 구분: 요청서, 견적서
	private int custom_order_category; // 카테고리 번호
}
