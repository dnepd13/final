package com.kh.ordering.service;
import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.entity.SellerDto;
public interface SellerService {
	//판매자 가입 Service
	void regist(SellerDto sellerDto);
	
	//판매자 로그인 Service
	SellerDto login(SellerDto sellerDto);
//	//판매자 정보조회
//	SellerDto info(SellerDto sellerDto);



//	//판메지 정보 수정
//	SellerDto info_edit(SellerDto sellerDto);

}
