package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MemberDto {

	private int member_no; //구매자번호 (시퀀스)
	private String member_id; //구매자아이디
	private String member_pw; //구매자비밀번호
	private String member_name; //구매자이름
	private String member_email; //구매자 이메일
	private String member_phone; //구매자전화번호
	private String member_birth; //구매자생년월일
	private String member_join_date; //구매자 가입일시
	private String member_last_login; //구매자 최종로그인
	private String member_agree_date; //구매자 약관동의시간
	private String member_grade; //구매자등급 bronze.silver.gold
	
}
