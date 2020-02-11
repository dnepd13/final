package com.kh.ordering.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.Member_AddrDto;
import com.kh.ordering.entity.SellerAlarmDto;

public interface MemberService {
//	회원 요청서 Service
	CustomOrderDto MemberCustom(HttpSession session,
														CustomOrderDto customOrderDto,
														MemberCustomOrderDto memberCustomDto,
														SellerAlarmDto sellerAlarmDto);

	
	
	
	
	
	
	
//배송지를  기억하기 위한 member_no 가져오기	
	static void Member_InsertAddr(HttpSession session, Member_AddrDto member_AddrDto) {
		// TODO Auto-generated method stub
		
	}

	
	


}
