package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CustomOrderFilesDto {
	private int files_no;
	private int custom_order_no;
}
