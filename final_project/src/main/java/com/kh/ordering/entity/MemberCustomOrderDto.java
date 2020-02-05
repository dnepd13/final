package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberCustomOrderDto {
	private int member_custom_order_no; // 요청서관리 고유번호
	private int member_no; // 회원번호
	private int custom_order_no; // 요청서번호
}
