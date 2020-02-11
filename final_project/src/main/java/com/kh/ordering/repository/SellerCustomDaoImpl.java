package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.CustomOrderFilesDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;

@Repository
public class SellerCustomDaoImpl implements SellerCustomDao {

	@Autowired
	private SqlSession sqlSession;
	
//	판매자id로 판매자 번호 구하기
	@Override
	public int getNo(String seller_id) {
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
	@Override // 견적서 관리테이블 .currval 시퀀스
	public int CustomOrderSeq() {
		return sqlSession.selectOne("seller.customOrderSeq");
	}

	@Override // 견적서 .currval 시퀀스
	public int CustomSeq() {	
		return sqlSession.selectOne("seller.customSeq");
	}

	@Override // 요청서 도착 알람 테이블 입력
	public void CustomAlarmInsert(SellerCustomAlarmDto sellerAlramDto) {
		sqlSession.insert("seller.insertAlarm", sellerAlramDto);
	}
	
	@Override // 파일 .nextval 시퀀스
	public int FilesSeq() {
		return sqlSession.selectOne("files.getSeq");
	}	
	@Override // 파일테이블 등록
	public void FilesInsert(FilesDto filesDto) {
		sqlSession.insert("files.insert", filesDto);
	}
	@Override // 주문제작-파일테이블
	public void CustomFilesInsert(CustomOrderFilesDto customOrderFilesDto) {
		sqlSession.insert("files.customInsert", customOrderFilesDto);
	}
	
	@Override // 구매자 1:1 요청서 보기(카테고리 조건 미구현)
	public List<CustomOrderVO> getListReq(int seller_no) {
		
		return sqlSession.selectList("seller.getListCustom", seller_no);
	}	
	@Override // 구매자 요청서 상세보기. 주문제작 번호 단일조회
	public CustomOrderVO customOrderVO(int member_custom_order_no) {		
		return sqlSession.selectOne("seller.getListInfo", member_custom_order_no);
	}	
	@Override // 요청서 상세페이지 접속하면 판매자 알람테이블 업데이트
	public void UpdateAlarm(int seller_no, int member_custom_order_no) {
		SellerCustomAlarmDto updateAlarm = SellerCustomAlarmDto.builder()
																														.seller_no(seller_no)
																														.member_custom_order_no(member_custom_order_no)
																														.build();
		sqlSession.update("seller.updateAlarm", updateAlarm);
	}
	
	// 내가 보낸 견적서 보기
	@Override
	public List<CustomOrderDto> getListResp(int seller_no) {
		
		return sqlSession.selectList("seller.getListResp", seller_no);
	}

}
