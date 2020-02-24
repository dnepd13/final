package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class AdminQnaDto {
	private int admin_qna_no, 
						seller_no, 
						member_no,
						admin_no,
						group_no,
						super_no;
	private String admin_qna_content,
							admin_qna_title,
							admin_qna_writer,
							admin_qna_usertype,
							admin_qna_date,
							admin_qna_head;

}
