package com.kh.ordering.repository;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ordering.entity.FilesDto;

// 파일 no로 파일정보 불러오기
public interface FilesDao {
	FilesDto getFiles(int files_no); // 파일 번호로 파일정보 가져오기

	void insertGoodsFiles(MultipartFile multipartFile, int goods_no);

	void insertGoodsFiles(MultipartFile[] multipartFile, int goods_no);
}
