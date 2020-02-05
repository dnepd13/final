package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerCustomOrderDto;

@Repository
public class SellerDaoImpl implements SellerDao {

	@Autowired
	private SqlSession sqlSession;
	
//	판매자id로 판매자 번호 구하기
	@Override
	public int SellerNo(String seller_id) {
		// seller_id 나중에 세션에서 가져와서 바꾸기
		int seller_no = sqlSession.selectOne("seller.getNo", seller_id);
		return seller_no;
	}

//	판매자 견적서 작성
	@Override // 견적서 저장
	public void CustomOrderInsert(CustomOrderDto customOrderDto) {
		sqlSession.insert("seller.customResp", customOrderDto);
	}

	@Override // 견적서 관리 저장
	public void SellerCustom(SellerCustomOrderDto sellerCustomDto) {
		sqlSession.insert("seller.customInsert", sellerCustomDto);
	}
	
	@Override // 견적서 시퀀스
	public int CustomSeq() {
		
		return sqlSession.selectOne("seller.customSeq");
	}

}