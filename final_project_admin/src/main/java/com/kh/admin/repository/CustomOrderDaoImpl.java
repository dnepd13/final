package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.vo.CustomOrderVO;
import com.kh.admin.vo.PagingVO;

@Repository
public class CustomOrderDaoImpl implements CustomOrderDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<CustomOrderVO> getList(PagingVO vo) {
		return sqlSession.selectList("admin.getCustomOrderList", vo);
	}

	@Override
	public int getCustomOrderCount(PagingVO vo) {
		return sqlSession.selectOne("admin.getCustomOrderCount", vo);
	}

	@Override
	public CustomOrderVO getOne(int no) {
		return sqlSession.selectOne("admin.getCustomOrderOne", no);
	}

}
