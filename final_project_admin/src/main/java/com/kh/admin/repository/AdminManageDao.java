package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.vo.PagingVO;

public interface AdminManageDao {
	List<AdminDto> getList();
	public int countBoard();
	public List<AdminDto> selectBoard(PagingVO vo);
	public void adminDelete(AdminDto adminDto);
}
