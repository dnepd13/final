package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class GoodsReviewDto {
	private int goods_review_no,
					goods_review_star,
					goods_no,
					ordering_no;
	private String goods_review_content,
						goods_review_writer,
						goods_review_date;
}
