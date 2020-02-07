package com.kh.ordering.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.SellerAlarmDto;

public interface MemberService {
//	회원 요청서 Service
	CustomOrderDto MemberCustom(HttpSession session,
														CustomOrderDto customOrderDto,
														MemberCustomOrderDto memberCustomDto,
														SellerAlarmDto sellerAlarmDto);

//로그인 상태확인



}
