package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class GoodsReviewDto {
	private int goods_no;
	private int cart_info_goods_no;
	private int member_no;
	
	private int goods_review_no;
	private String goods_review_content;
	private String goods_review_writer;
	private String goods_review_date;
	private double goods_review_star;
}
