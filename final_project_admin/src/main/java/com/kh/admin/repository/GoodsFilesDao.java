package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.FilesDto;

public interface GoodsFilesDao {
	public List<FilesDto> getGoodsFiles(int goods_no);
	public FilesDto getFile(int files_no);
	
}
