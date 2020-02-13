package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.SellerDto;
import com.kh.admin.vo.BlockSellerVO;
import com.kh.admin.vo.PagingVO;

@Repository
public class SellerDaoImpl implements SellerDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sellerCount() {
		int result = sqlSession.selectOne("admin.sellerCount");
		return result;
	}

	@Override
	public List<BlockSellerVO> sellerGetList(PagingVO vo) {
			
		List<BlockSellerVO> list = sqlSession.selectList("admin.sellerGetList", vo);
		return list;
	}

	//판매자 단일 조회
	@Override
	public SellerDto sellerGetOne(SellerDto sellerDto) {
		
		return sqlSession.selectOne("admin.sellerGetOne", sellerDto);
	}

	@Override
	public void sellerDelete(SellerDto sellerDto) {
		sqlSession.delete("admin.sellerDelete", sellerDto);
	}

	@Override
	public int sellerIdCount(String seller_id) {
		return sqlSession.selectOne("admin.sellerIdCount", seller_id);
	}

	@Override
	public int sellerGradeCount(String seller_grade) {
		return sqlSession.selectOne("admin.sellerGradeCount", seller_grade);
	}

}
