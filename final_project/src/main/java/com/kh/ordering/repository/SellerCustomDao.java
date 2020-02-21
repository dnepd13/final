package com.kh.ordering.repository;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.CustomOrderFilesDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

public interface SellerCustomDao {
// 판매자 주문제작 Dao
	//판매자 아이디로 번호 가져오기
	int getNo(@RequestParam String seller_id);
	
	//판매자 견적서 작성
	void customOrderInsert(CustomOrderDto customOrderDto); // 견적서 저장 테이블
	int customSeq();// 주문제작.currval 시퀀스 번호
	void sellerCustom(SellerCustomOrderDto sellerCustomDto); // 견적서 관리 테이블
	int customOrderSeq(); // 견적서 관리테이블.currval 시퀀스
	void customAlarmInsert(SellerCustomAlarmDto sellerCustomAlarmDto); 	//요청서 도착 알람 테이블
	void customFilesInsert(CustomOrderFilesDto customOrderFilesDto); // 주문제작-파일테이블
	
	//받은 요청서 보기
	List<CustomOrderVO> getListReq(PagingVO paging); // 목록
	//받은 요청서 단일조회, 상세내용
	CustomOrderVO customOrderVO1(int member_custom_order_no, int seller_no);
	//요청서 누르면 판매자 알림테이블 업데이트
	void updateAlarm(int seller_no, int member_custom_order_no);
	//판매자 알람테이블 check N
	int customAlarm(int seller_no);
	SellerCustomAlarmDto getsellerAlarm(int member_custom_order_no);
	
	//받은 요청서 삭제
	void deleteCustomReq(SellerCustomAlarmDto sellerAlarmDto);
	//보낸 견적서 삭제
	int getCustomNo(int seller_custom_order_no);
	void deleteCustomResp(int custom_order_no);
	//구매자의 견적서 알람테이블 삭제
	void deleteAlarm(int seller_custom_order_no);
	
	// 파일 출력용
	List<FilesVO> getFilesNo(int seller_custom_order_no);
	
	//판매자가 받은 요청서 count
	int customReqCount(int seller_no);
	
	//내가 보낸 견적서 보기
	List<CustomOrderDto> getListResp(PagingVO paging);	//목록
	CustomOrderVO customOrderVO2(int seller_custom_order_no); // 상세보기
	int customRespCount(int seller_no); // 내가 보낸 견적서 총 개수
}
