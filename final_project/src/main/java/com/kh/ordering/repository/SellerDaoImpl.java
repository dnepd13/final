package com.kh.ordering.repository;



import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.vo.CustomOrderVO;

@Repository
public class SellerDaoImpl implements SellerDao {
	@Autowired
	private SqlSession sqlSession;
	private int info_edit;
	//판매자 번호 시퀀스
	@Override
	public int getSequence() {
		int result = sqlSession.selectOne("seller.sequence");
		return result;
	}
//판매자 가입
	@Override
	public void regist(SellerDto sellerDto) {
		sqlSession.insert("seller.regist",sellerDto);
	
	}
//판매자 로그인
	@Override
	public SellerDto login(SellerDto sellerDto) {
			System.out.println("sellerDaoimpl Dto ="+sellerDto);
		 	SellerDto find = sqlSession.selectOne("seller.login",sellerDto);
		 	System.out.println("sellerDaoimpl Find ="+find);
			return find;
		
	}
	//판매 정보 조회
	@Override
	public SellerDto info(SellerDto sellerDto) {
    SellerDto info = sqlSession.selectOne("seller.info", sellerDto);
		return sellerDto;
	}
//	@Override
//	public SellerDto info_edit(SellerDto sellerDto) {
//	 info_edit =sqlSession.update("seller.info_edit", sellerDto);
//		return sellerDto;
	//}


}
