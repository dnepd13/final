package com.kh.ordering.service;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.SellerAlarmDto;

public interface MemberCustomService {
//	회원 요청서 Service
	CustomOrderDto MemberCustom(HttpSession session,
														CustomOrderDto customOrderDto,
														MemberCustomOrderDto memberCustomDto,
														SellerAlarmDto memberAlarmDto);
}
