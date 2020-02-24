package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.CalculateDto;
import com.kh.admin.vo.AdjustmentFullVO;
import com.kh.admin.vo.AdjustmentInsertVO;
import com.kh.admin.vo.CalculateVO;
import com.kh.admin.vo.PagingVO;

public interface CalculateDao {
	public List<String> calculateGetSeller(PagingVO adjustmentInsertVO);
	public List<AdjustmentFullVO> getCalculate(PagingVO adjustmentInsertVO);
	public int getRate(int price);
	public int calculateCount(AdjustmentInsertVO vo);
	public List<AdjustmentFullVO> getOneSeller(PagingVO vo);
	
	//판매자 한명의 목록 카운트구하기
	public int oneSellerCount(AdjustmentInsertVO vo);
	
	
	//정산하기
	public void insert(CalculateDto calculateDto);
}
