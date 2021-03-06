package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ordering.entity.BlockDto;

@Service
public class SellerBlockDaoImpl implements SellerBlockDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public BlockDto sellerBlock(String id) {
		return sqlSession.selectOne("block.seller", id);
	}

	@Override // seller 번호로 블락내용 좀 가져가겠습니다 ...
	public BlockDto blockDto(int seller_no) {
		return sqlSession.selectOne("block.getSellerInfo", seller_no);
	}

}
