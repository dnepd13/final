package com.kh.ordering.repository;

import com.kh.ordering.entity.MemberDto;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
	
	
	
	//판매자 견적서 보기
	List<CustomOrderDto> getListCustom();
	//내가 보낸 요청서 보기
	List<CustomOrderDto> getListReq(int member_no);
    
	
//회원 정보 가입

		
		
//		MemberDto getMemberDto(int seq) throws Exception;
		// 멤버 테이블 시퀀스
		int MemberSeq();
		
		
		// 멤버 테이블 가입
		void regist(MemberDto member);
		
	
		//로그인 
		MemberDto login(MemberDto member);
		
		//회원 최종로그인변동
		void lastLogin(MemberDto member);
		
//		//멤버아이디로 번호 구해오기
//		int findno(@RequestParam MemberDto member, int member_no);
//		



}