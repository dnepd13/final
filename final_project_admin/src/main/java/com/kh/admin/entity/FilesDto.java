package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class FilesDto {
	private int files_no,
					files_size,
					goods_no,
					custom_order_no;
	private String files_savename,
						files_uploadname;
}
