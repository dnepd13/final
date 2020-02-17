package com.kh.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReviewVO {
	private int goods_review_no,
					goods_review_star,
					goods_no,
					ordering_no,
					goods_review_reply_no;
	private String goods_review_content,
					goods_review_writer,
					goods_review_date,
					goods_review_reply_content,
					goods_review_reply_writer,
					goods_review_reply_date;
}
