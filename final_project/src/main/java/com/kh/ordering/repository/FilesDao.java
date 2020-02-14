package com.kh.ordering.repository;

import com.kh.ordering.entity.FilesDto;

// 파일 no로 파일정보 불러오기
public interface FilesDao {
	FilesDto getFiles(int files_no); // 파일 번호로 파일정보 가져오기
}
