package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.vo.CalculateVO;
import com.kh.admin.vo.PagingVO;

public interface CalculateDao {
	public List<CalculateVO> calculate(String id);
	public List<String> sellerCollect(PagingVO vo);
	public List<String> sellerTotalCollect();
}
