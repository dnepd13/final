package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//판매자 요청서 도착 알람
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberCustomAlarmDto {
	private int member_alarm_no; // 구매자 요청서 도착 알람 고유번호
	private int member_no; // 구매자 번호
	private int seller_custom_order_no; // 판매자 견적서 고유번호
	private String member_alarm_date; // 구매자 알람 확인시간
	private String member_alarm_check; // 구매자 알람 체크여부
	private String member_alarm_delete; // 구매자 알람 삭제
}
