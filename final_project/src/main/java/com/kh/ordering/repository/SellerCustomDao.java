package com.kh.ordering.repository;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.CustomOrderFilesDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;

public interface SellerCustomDao {
// 판매자 주문제작 Dao
	//판매자 아이디로 번호 가져오기
	int getNo(@RequestParam String seller_id);
	
	//판매자 견적서 작성
	void CustomOrderInsert(CustomOrderDto customOrderDto); // 견적서 저장 테이블
	int CustomSeq();// 주문제작.currval 시퀀스 번호
	void SellerCustom(SellerCustomOrderDto sellerCustomDto); // 견적서 관리 테이블
	int CustomOrderSeq(); // 견적서 관리테이블.currval 시퀀스
	void CustomAlarmInsert(SellerCustomAlarmDto sellerCustomAlarmDto); 	//요청서 도착 알람 테이블
	int FilesSeq(); // 파일 .nextval 시퀀스번호
	void FilesInsert(FilesDto filesDto);
	void CustomFilesInsert(CustomOrderFilesDto customOrderFilesDto); // 주문제작-파일테이블
	
	//구매자 1:1 요청서 보기
	List<CustomOrderVO> getListReq(int seller_no);
	//구매자 요청서 단일조회, 상세내용
	CustomOrderVO customOrderVO(int member_custom_order_no);
	//요청서 누르면 판매자 알림테이블 업데이트
	void UpdateAlarm(int seller_no, int member_custom_order_no);
	//내가 보낸 견적서 보기
	List<CustomOrderDto> getListResp(int seller_no);

}
