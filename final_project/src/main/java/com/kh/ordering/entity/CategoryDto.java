package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CategoryDto {
	private int category_no;
	private String category_large;
	private String category_middle;
	private String category_small;
}
