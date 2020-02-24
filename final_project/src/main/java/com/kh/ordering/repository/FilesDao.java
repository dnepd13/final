package com.kh.ordering.repository;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ordering.entity.FilesDto;

// 파일 no로 파일정보 불러오기
public interface FilesDao {
	int getSeq(); // 파일테이블 다음 시퀀스번호 가져오기
	FilesDto getFiles(int files_no); // 파일 번호로 파일정보 가져오기

	int insertGoodsFiles(MultipartFile multipartFile, int goods_no);

	List<Integer> insertGoodsFiles(MultipartFile[] multipartFile, int goods_no);
	void filesInsert(FilesDto filesDto); // 파일 저장
}
