package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CartOkDto {
	private int cart_ok_no;
	private int member_no;
	private int cart_info_no;
	
	private String cart_ok_date;
	private String cart_ok_status;
}
