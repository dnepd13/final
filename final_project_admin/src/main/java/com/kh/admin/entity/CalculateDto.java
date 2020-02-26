package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CalculateDto {
	private String calculate_start,
						calculate_finish,
						calculate_ok_date,
						calculate_status,
						seller_id
						;
	
	private int calculate_no,
					seller_no,
					calculate_total,
					calculate_exception,
					calculate_final;
}
