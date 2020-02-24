package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class GoodsReviewFilesDto {
	private int files_no;
	private int goods_review_no;
	private int member_no;
}
