package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.vo.CalculateVO;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class CalculateDaoImpl implements CalculateDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<CalculateVO> calculate(String id) {
		log.info("여기는?");
		return sqlSession.selectList("admin.calculate", id);
	}

	@Override
	public List<String> sellerCollect(PagingVO vo) {
		log.info("여까지 들어오나");
		return sqlSession.selectList("admin.sellerOnlyId", vo);
	}

	@Override
	public List<String> sellerTotalCollect() {
		return sqlSession.selectList("admin.sellerTotalCollect");
	}

}
