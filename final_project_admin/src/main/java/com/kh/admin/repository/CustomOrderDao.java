package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.vo.CustomOrderVO;
import com.kh.admin.vo.PagingVO;

public interface CustomOrderDao {
	public List<CustomOrderVO> getList(PagingVO vo);
	public int getCustomOrderCount(PagingVO vo);
	public CustomOrderVO getOne(int no);
}
