package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CompanyInfoDto {
	private String co_name,
						co_ceo,
						co_location,
						co_call,
						co_email,
						co_termsofuse,
						co_privacy;
}
