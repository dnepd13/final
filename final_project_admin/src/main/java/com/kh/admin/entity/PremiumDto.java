package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PremiumDto {
	private int premium_no,
					premium_price,
					premium_rate;
}
