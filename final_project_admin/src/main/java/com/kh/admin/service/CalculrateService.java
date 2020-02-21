package com.kh.admin.service;

import java.util.List;

import com.kh.admin.vo.FinalCalculateVO;
import com.kh.admin.vo.PagingVO;

public interface CalculrateService {
	public List<FinalCalculateVO> calculrate(PagingVO vo);
}
