package com.kh.ordering.repository;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;

public interface MemberCustomDao {

	//회원 아이디로 번호 가져오기
	int getNo(@RequestParam String member_id);
	
	//회원 요청서 작성
	void CustomOrderInsert(CustomOrderDto customOrderDto); // 요청서 저장 테이블
	int CustomSeq();// 요청서 시퀀스 번호
	void MemberCustom(MemberCustomOrderDto memberCustomDto); // 요청서 관리 테이블
	//판매자 견적서 보기
	List<CustomOrderDto> getListCustom();
	//판매자 견적서 단일조회
	CustomOrderVO customOrderVO(int custom_order_no);
	//내가 보낸 요청서 보기
	List<CustomOrderDto> getListReq(int member_no);
	//견적서 도착 알람 테이블 생성
	void CustomAlarmInsert(MemberCustomAlarmDto memberCustomAlarmDto);
	

}
