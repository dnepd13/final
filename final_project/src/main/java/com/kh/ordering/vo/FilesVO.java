package com.kh.ordering.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class FilesVO {
	// 파일 업로드용 List
	private List<MultipartFile> files;
	
	// 파일 출력용 
	private int files_no;
}
