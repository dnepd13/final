package com.kh.ordering.service;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerCustomOrderDto;

public interface SellerService {
//	판매자 견적서 Service
	CustomOrderDto SellerCustom(HttpSession session,
													CustomOrderDto customOrderDto,
													SellerCustomOrderDto sellerCustomDto);
}
