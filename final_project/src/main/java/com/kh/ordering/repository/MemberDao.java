package com.kh.ordering.repository;

import com.kh.ordering.entity.MemberDto;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;

public interface MemberDao {

// 회원 주문제작 Dao

	
//회원 정보 가입

		
		
//		MemberDto getMemberDto(int seq) throws Exception;
		
	// 멤버 테이블 시퀀스 생성
		int MemberSeq();
		
		
		// 회원 가입
		void regist(MemberDto member);
		
	
		//회원 로그인 
		MemberDto login(MemberDto member);
		
		//회원 최종로그인변동
		void lastLogin(MemberDto member);

		//세션에 있는 id를 통해 번호구하기
		int getNo(@RequestParam String member_id);


		public MemberDto memberGetOne(MemberDto member);


		public void memberedit(MemberDto member);


//		List<MemberDto> memberGetOne(int member_no);
		
//		//멤버아이디로 번호 구해오기 (영락)
//		int findno(@RequestParam MemberDto member, int member_no);
		



}

