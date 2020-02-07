package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class Member_PointDto {

	private int member_point_no;		// 구매자 포인트 넘버(pk)
	private String member_point_status; // 구매자 포인트 상태
	private String member_point_date; 	// 구매자 포인트 상태 변환일
	private String member_point_limit;  // 구매자 포인트 유효기간
	private int member_point_change; 	// 구매자 포인트
	private String member_point_content; // 구매자 포인트 사유
	private int member_no;				//구매자 테이블 (fk)
}
