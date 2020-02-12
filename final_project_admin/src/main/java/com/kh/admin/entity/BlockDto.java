package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class BlockDto {
	private int block_no,
					member_no,
					seller_no;
	private String block_content,
						block_id,
						block_group,
						block_date;
}
