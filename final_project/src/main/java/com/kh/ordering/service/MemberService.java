package com.kh.ordering.service;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.Member_AddrDto;

public interface MemberService {
//	회원 요청서 Service
	CustomOrderDto MemberCustom(HttpSession session,
					CustomOrderDto customOrderDto,
					MemberCustomOrderDto memberCustomDto);
	
//배송지를  기억하기 위한 member_no 가져오기	
	static void Member_InsertAddr(HttpSession session, Member_AddrDto member_AddrDto) {
		// TODO Auto-generated method stub
		
	}

}
