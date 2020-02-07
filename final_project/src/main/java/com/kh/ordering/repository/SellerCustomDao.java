package com.kh.ordering.repository;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;

public interface SellerCustomDao {
// 판매자 주문제작 Dao
	//판매자 아이디로 번호 가져오기
	int getNo(@RequestParam String seller_id);
	
	//판매자 견적서 작성
	void CustomOrderInsert(CustomOrderDto customOrderDto); // 견적서 저장 테이블
	int CustomSeq();// 견적서 시퀀스 번호
	void SellerCustom(SellerCustomOrderDto sellerCustomDto); // 견적서 관리 테이블
	
	//구매자 1:1 요청서 보기
	List<CustomOrderVO> getListCustom(int seller_no);
	//구매자 요청서 단일조회
	CustomOrderVO customOrderVO(int custom_order_no);
	//내가 보낸 견적서 보기
	List<CustomOrderDto> getListResp(int seller_no);
	//요청서 도착 알람 테이블 생성
	void CustomAlarmInsert(SellerCustomAlarmDto sellerCustomAlarmDto);
}
