package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class GoodsReviewReplyDto {
	private int goods_review_reply_no;
	private int goods_review_no;
	private int member_no;
	
	private String goods_review_reply_content;
	private String goods_review_reply_writer;
	private String goods_review_reply_data;
}
