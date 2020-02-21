package com.kh.ordering.repository;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.CustomOrderFilesDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

public interface MemberCustomDao {

	//회원 아이디로 번호 가져오기
	int getNo(@RequestParam String member_id);

	//회원 요청서 작성
	void customOrderInsert(CustomOrderDto customOrderDto); // 요청서 저장 테이블
	int customSeq();// 주문제작 .currval 시퀀스 번호
	void memberCustom(MemberCustomOrderDto memberCustomDto); // 요청서 관리 테이블
	int customOrderSeq(); // 요청서 관리테이블 .currval 시퀀스
	void customAlarmInsert(MemberCustomAlarmDto memberCustomAlarmDto); //견적서 도착 알람 테이블 생성
	void customFilesInsert(CustomOrderFilesDto customOrderFilesDto); // 주문제작-파일 테이블
	
	//판매자 1:1 견적서 보기
	List<CustomOrderVO> getListResp(PagingVO paging);
	//판매자 견적서 단일조회, 상세조회
	CustomOrderVO customOrderVO1(int seller_custom_order_no);
	//견적서 누르면 구매자 알림테이블 업데이트
	void updateAlarm(int member_no, int seller_custom_order_no);
	//구매 알람테이블 견적서 총 개수 check N
	int customAlarm(int member_no);
	
	// 수정
	void updateCustom(CustomOrderDto customOrderDto);
	
	//보낸 요청서 삭제 (1:1)
	int getCustomNo(int member_custom_order_no);
	void deleteCustomReq(int custom_order_no);
	//                        (카테고리)
	void deleteAlarm(int member_custom_order_no);
	void deleteCustom(int member_custom_order_no);
	
	// 파일 출력용
	List<FilesVO> getFilesNo(int member_custom_order_no); // 요청서의 파일 No 가져오기
	
	//구매자가 받은 견적서 count
	int customRespCount(int member_no);
	
	//내가 보낸 요청서 보기
	List<CustomOrderVO> getListReq(PagingVO paging); // 목록
	CustomOrderVO customOrderVO2(int member_custom_order_no); // 상세보기
	int customReqCount(int member_no); // 내가 보낸 요청서 총 개수
}
