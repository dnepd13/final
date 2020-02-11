package com.kh.ordering.service;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.vo.FilesVO;

public interface SellerCustomService {
//	판매자 견적서 Service
	CustomOrderDto SellerCustom(HttpSession session, int member_no,
													FilesVO files,
													CustomOrderDto customOrderDto,
													SellerCustomOrderDto sellerCustomDto,
													MemberCustomAlarmDto memberCustomAlarmDto) throws IllegalStateException, IOException;
}
