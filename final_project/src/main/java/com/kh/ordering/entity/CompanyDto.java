package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CompanyDto {
	private String co_name;
	private String co_ceo;
	private String co_location;
	private String co_call;
	private String co_email;
	private String co_termsofuse; // 이용약관
	private String co_privancy; //개인정보약관
}
