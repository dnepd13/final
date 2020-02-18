package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class GradeBenefitDto {
	private int grade_benefit_no,
					grade_benefit_rate;
	private String grade_benefit_grade;
}
