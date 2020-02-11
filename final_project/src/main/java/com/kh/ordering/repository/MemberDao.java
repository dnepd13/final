package com.kh.ordering.repository;

import com.kh.ordering.entity.MemberDto;
import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;

public interface MemberDao {
	
//회원 정보 가입

		
		
//		MemberDto getMemberDto(int seq) throws Exception;
		// 멤버 테이블 시퀀스
		int MemberSeq();
		
		// 멤버 테이블 가입
		void regist(MemberDto member);

}
