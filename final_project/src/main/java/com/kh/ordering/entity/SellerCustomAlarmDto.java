package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//판매자 요청서 도착 알람
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class SellerCustomAlarmDto {
	private int seller_alarm_no; // 판매자 요청서 도착 알람 고유번호
	private int seller_no; // 판매자 번호
	private int member_custom_order_no; // 회원 요청서 고유번호
	private String seller_alarm_date; // 판매자 알람 확인시간
	private String seller_alarm_check; // 판매자 알람 체크여부
	private String seller_alarm_delete; // 판매자 알람 삭제
}
