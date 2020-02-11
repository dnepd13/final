package com.kh.ordering.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 다수의 파일이 업로드 될 때를 위한 클래스
@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class FilesVO {
	private List<MultipartFile> files;
}
