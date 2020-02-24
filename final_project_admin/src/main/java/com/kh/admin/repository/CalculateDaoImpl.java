package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.kh.admin.entity.CalculateDto;

import com.kh.admin.vo.AdjustmentFullVO;
import com.kh.admin.vo.AdjustmentInsertVO;
import com.kh.admin.vo.CalculateVO;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class CalculateDaoImpl implements CalculateDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<String> calculateGetSeller(PagingVO adjustmentInsertVO) {
		return sqlSession.selectList("admin.adjustmentGetSeller", adjustmentInsertVO);
	}

	@Override
	public List<AdjustmentFullVO> getCalculate(PagingVO adjustmentInsertVO) {
		return sqlSession.selectList("admin.adjustment", adjustmentInsertVO);
	}

	@Override
	public int getRate(int price) {
		return sqlSession.selectOne("admin.getRate", price);
	}

	@Override
	public int calculateCount(AdjustmentInsertVO vo) {
		List<String> cal = sqlSession.selectList("admin.adjustmentCount", vo);
		int result = cal.size();
		return result;
	}

	@Override
	public List<AdjustmentFullVO> getOneSeller(PagingVO vo) {
		
		return sqlSession.selectList("admin.adjustmentOne", vo);
	}

	@Override
	public int oneSellerCount(AdjustmentInsertVO vo) {
		return sqlSession.selectOne("admin.adjustmentOneCount", vo);
	}


	@Override
	public void insert(CalculateDto calculateDto) {
		sqlSession.insert("admin.insertCal", calculateDto);
		
	}

}
