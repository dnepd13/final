package com.kh.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MemberPointVO {
	private int member_no,
					member_point_no,
					member_point_change;
	private String 
						member_point_status,
						member_point_date,
						member_point_limit,
						member_point_content,
						member_point_admin;
	
}
