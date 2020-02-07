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
	
	@Override // 구매자 요청서 전체보기(카테고리 조건 미구현)
	public List<CustomOrderDto> getListCustom() {
		
		return sqlSession.selectList("seller.getListCustom");
	}
	// 내가 보낸 견적서 보기
	@Override
	public List<CustomOrderDto> getListResp(int seller_no) {
		
		return sqlSession.selectList("seller.getListResp", seller_no);
	}
	// 요청서 도착 알림 생성
	@Override
	public void CustomAlarmInsert(SellerAlarmDto sellerAlramDto) {
		sqlSession.insert("seller.insertAlarm", sellerAlramDto);
	}

	@Override // 요청서 상세보기. 주문제작 번호 단일조회
	public CustomOrderVO customOrderVO(int custom_order_no) {		
		return sqlSession.selectOne("seller.getCustomNo", custom_order_no);
	}


}
