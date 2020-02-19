package com.kh.ordering.entity;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class SellerCategoryDto {
	private int seller_no;
	private int category_no;
}
