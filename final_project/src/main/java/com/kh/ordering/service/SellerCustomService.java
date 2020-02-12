package com.kh.ordering.service;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

public interface SellerCustomService {
//	판매자 견적서 Service
	// 견적서 작성
	CustomOrderDto SellerCustom(HttpSession session, int member_no,
													FilesVO files,
													CustomOrderDto customOrderDto,
													SellerCustomOrderDto sellerCustomDto,
													MemberCustomAlarmDto memberCustomAlarmDto) throws IllegalStateException, IOException;
	
	// 요청서 목록 내비게이터
	PagingVO customReqPaging(String pageNo, int seller_no);
	// 견적서 목록 내비게이터
	PagingVO customRespPaging(String pageNo, int seller_no);
}
