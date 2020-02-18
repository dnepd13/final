package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class GoodsQnaDto {
	private int goods_qna_no;
	private int goods_no;
	private int seller_no;
	
	private String goods_qna_content;
	private String goods_qna_writer;
	private String goods_qna_date;
	private String goods_qna_head;
	private String goods_qna_status;
	
	private int goods_qna_groupno;
	private int goods_qna_superno;

}
