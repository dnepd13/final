package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MemberDto {
	private int member_no;
	private String member_id,
						member_pw,
						member_name,
						member_email,
						member_phone,
						member_birth,
						member_join_date,
						member_last_login,
						member_agree_date,
						member_grade;
}
