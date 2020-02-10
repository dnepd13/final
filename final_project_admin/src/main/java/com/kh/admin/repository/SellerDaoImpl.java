package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.admin.entity.SellerDto;
import com.kh.admin.vo.PagingVO;

public class SellerDaoImpl implements SellerDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sellerCount() {
		int result = sqlSession.selectOne("admin.sellerCount");
		return result;
	}

	@Override
	public List<SellerDto> sellerGetList(PagingVO vo) {
			
		List<SellerDto> list = sqlSession.selectList("admin.sellerGetList", vo);
		return list;
	}

}
