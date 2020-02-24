package com.kh.ordering.repository;



import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.SellerDto;

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
	//		System.out.println("sellerDaoimpl Dto ="+sellerDto);
		 	SellerDto find = sqlSession.selectOne("seller.login",sellerDto);
		// 	System.out.println("sellerDaoimpl Find ="+find);
			return find;
		
	}
	//판매 정보 조회
	@Override
	public SellerDto info(SellerDto sellerDto) {
    SellerDto info = sqlSession.selectOne("seller.info", sellerDto);
		return info;
	}
//	@Override
//	public SellerDto info_edit(SellerDto sellerDto) {
//	 info_edit =sqlSession.update("seller.info_edit", sellerDto);
//		return sellerDto;
	//}
	//////판매자 정보수정
	@Override
	public SellerDto info_edit(SellerDto sellerDto) {
		 info_edit =sqlSession.update("seller.info_edit",sellerDto);
		 return sellerDto;
		
	}
	//판매자 회원탈퇴
	@Override
	public void delete(SellerDto sellerDto) {
		   sqlSession.delete("seller.delete",sellerDto);
		
	}
	//판매자 비밀번호 변경
	@Override
	public void change_pw(SellerDto sellerDto) {
			sqlSession.update("seller.change_pw",sellerDto);
	}
//	@Override
//	public SellerDto change_pw(SellerDto sellerDto) {
//              sqlSession.update("seller.change_pw",sellerDto);
//				return sellerDto;
//	 
//	}
	//판매자 아이디 중복 검사
	
//	@Override
//	public int check_id(String seller_id) {
//		int count = sqlSession.selectOne("seller.check_id",seller_id);
//		return count;
//	}

	
	
	//판매자 아이디 중복 검사
//
//
	@Override
	public int id_check(String seller_id) {
		return 0;
	}
	//판매자 아이디찾기
	@Override
	public SellerDto find_id(SellerDto sellerDto) {
		SellerDto find_id=sqlSession.selectOne("seller.find_id", sellerDto);
		return find_id;
	}

	


}
