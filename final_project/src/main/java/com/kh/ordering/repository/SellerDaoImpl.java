package com.kh.ordering.repository;



import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.SellerDto;
@Repository
public class SellerDaoImpl implements SellerDao {
@Autowired
private SqlSession sqlSession;

	@Override
	public int getSequence() {
		int result = sqlSession.selectOne("seller.sequence");
		return result;
	}

	@Override
	public void regist(SellerDto sellerDto) {
		sqlSession.insert("seller.regist",sellerDto);
	
	}

	@Override
	public SellerDto login(SellerDto sellerDto) {
			System.out.println("sellerDaoimpl Dto ="+sellerDto);
		 	SellerDto find = sqlSession.selectOne("seller.login",sellerDto);
		 	System.out.println("sellerDaoimpl Find ="+find);
			return find;
		
	}



		
}
