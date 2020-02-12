package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor @NoArgsConstructor @Builder @Data
public class Member_AddrDto {

	private int member_addr_no;
	private String member_name_extra;
	private String member_addr_post;
	private String member_addr_basic;
	private String member_addr_extra;
	private String member_addr_status;
	private int member_no;
	
}
