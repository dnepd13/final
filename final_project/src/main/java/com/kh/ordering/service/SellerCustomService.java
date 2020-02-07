package com.kh.ordering.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;

public interface SellerCustomService {
//	판매자 견적서 Service
	CustomOrderDto SellerCustom(HttpSession session, int seller_no,
													CustomOrderDto customOrderDto,
													SellerCustomOrderDto sellerCustomDto,
													MemberCustomAlarmDto memberCustomAlarmDto);
}
