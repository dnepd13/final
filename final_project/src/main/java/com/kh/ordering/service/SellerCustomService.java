package com.kh.ordering.service;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;

public interface SellerCustomService {
//	판매자 견적서 Service
	CustomOrderDto SellerCustom(HttpSession session, int seller_no,
													CustomOrderDto customOrderDto,
													SellerCustomOrderDto sellerCustomDto,
													MemberAlarmDto memberAlarmDto);
}
