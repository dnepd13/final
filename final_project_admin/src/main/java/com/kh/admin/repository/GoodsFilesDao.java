package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.FilesDto;

public interface GoodsFilesDao {
	public List<FilesDto> getGoodsFiles(int goods_no);
	public FilesDto getFile(int files_no);
	
	
	//주문제작 사진 가져오기
	public List<FilesDto> getCustomOrderFiles(int custom_files_no);
}
