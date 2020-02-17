package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.AdminQnaBoardDto;
import com.kh.admin.entity.BlockDto;
import com.kh.admin.entity.CategoryDto;
import com.kh.admin.vo.PagingVO;

public interface AdminDao {
	AdminDto login(AdminDto adminDto);
	void regist(AdminDto adminDto);
	void lastLogin(AdminDto adminDto);
	void block(BlockDto blockDto);
	int blockCount();
	List<BlockDto> blockList(PagingVO paging);
	void blockDelete(BlockDto blockDto);
	public int blockGroupCount(String block_group);
	public int blockIdCount(String block_id);
	
	public int registToday();
}
