package com.kh.ordering.repository;

import java.util.List;

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


}
