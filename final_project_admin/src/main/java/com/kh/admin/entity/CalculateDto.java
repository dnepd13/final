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
						calculate_total,
						calculate_exception,
						calculate_final;
	
	private int calculate_no,
					ordering,
					member,
					non;
					
}
