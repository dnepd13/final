package com.kh.ordering.service;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.vo.FilesVO;

public interface MemberCustomService {
//	회원 요청서 Service
	CustomOrderDto MemberCustom(HttpSession session, int seller_no,
																FilesVO files,
																CustomOrderDto customOrderDto,
																SellerCustomAlarmDto sellerCustomAlarmDto)
																throws IllegalStateException, IOException;

}
