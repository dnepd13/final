package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.AdminQnaBoardDto;
import com.kh.admin.vo.PagingVO;

public interface BoardDao {
	public int adminQnaCount();
	public List<AdminQnaBoardDto> qnaBoardGetList(PagingVO vo);
	public AdminQnaBoardDto qnaBoardGetOne(AdminQnaBoardDto adminQnaBoardDto);
}
