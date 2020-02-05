package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class TestDto {
	private int admin_no;
	private String admin_id,
						admin_pw,
						admin_name,
						admin_email,
						admin_grade,
						admin_join_date,
						admin_last_login;
}
