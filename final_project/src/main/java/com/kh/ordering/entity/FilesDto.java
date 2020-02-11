package com.kh.ordering.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class FilesDto {
	private int files_no;
	private long files_size;
	private String files_savename; // DB저장이름
	private String files_uploadname; // origin name
}
