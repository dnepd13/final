package com.kh.admin.service;

import java.util.List;

import com.kh.admin.vo.AdjustmentFullVO;
import com.kh.admin.vo.AdjustmentInsertVO;
import com.kh.admin.vo.AdjustmentVO;
import com.kh.admin.vo.FinalCalculateVO;
import com.kh.admin.vo.PagingVO;

public interface CalculrateService {
	public List<AdjustmentVO> getCalculSeller(PagingVO vo);
	
	//은행 코드로 이름 가져오기
	public String getBankName(String bankcode);
}
