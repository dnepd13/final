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
	void CustomOrderInsert(CustomOrderDto customOrderDto); // 요청서 저장 테이블
	int CustomSeq();// 주문제작 .currval 시퀀스 번호
	void MemberCustom(MemberCustomOrderDto memberCustomDto); // 요청서 관리 테이블
	int CustomOrderSeq(); // 요청서 관리테이블 .currval 시퀀스
	void CustomAlarmInsert(MemberCustomAlarmDto memberCustomAlarmDto); //견적서 도착 알람 테이블 생성
	int FileSeq(); // 파일 .nextval 시퀀스번호
	void FilesInsert(FilesDto filesDto); // 파일 저장
	void CustomFilesInsert(CustomOrderFilesDto customOrderFilesDto); // 주문제작-파일 테이블
	
	//판매자 1:1 견적서 보기
	List<CustomOrderVO> getListResp(PagingVO paging);
	//판매자 견적서 단일조회, 상세조회
	CustomOrderVO customOrderVO1(int seller_custom_order_no);
	//견적서 누르면 구매자 알림테이블 업데이트
	void UpdateAlarm(int member_no, int seller_custom_order_no);
	//구매 알람테이블 견적서 총 개수 check N
	int customAlarm(int member_no);
	
	// 파일 출력용
	List<FilesVO> getFilesNo(int member_custom_order_no); // 요청서의 파일 No 가져오기
	
	//구매자가 받은 견적서 count
	int customRespCount(int member_no);
	
	//내가 보낸 요청서 보기
	List<CustomOrderVO> getListReq(PagingVO paging); // 목록
	CustomOrderVO customOrderVO2(int member_custom_order_no); // 상세보기
	int customReqCount(int member_no); // 내가 보낸 요청서 총 개수
}
