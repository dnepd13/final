package com.kh.ordering.repository;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;

public interface MemberDao {
// 회원 주문제작 Dao
	//회원 아이디로 번호 가져오기
	int MemberNo(@RequestParam String member_id);
	
	//회원 요청서 작성
	void CustomOrderInsert(CustomOrderDto customOrderDto); // 요청서 저장 테이블
	int CustomSeq();// 요청서 시퀀스 번호
	void MemberCustom(MemberCustomOrderDto memberCustomDto); // 요청서 관리 테이블
}