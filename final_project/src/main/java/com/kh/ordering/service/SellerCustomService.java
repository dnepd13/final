package com.kh.ordering.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.repository.SellerDao;

@Service
public class SellerCustomService implements SellerService{
	
	@Autowired
	private SellerDao sellerDao;

	@Override
	public CustomOrderDto SellerCustom(HttpSession session,
																CustomOrderDto customOrderDto,
																SellerCustomOrderDto sellerCustomDto) {
		
		// 세션에서 판매자 번호 구하고
		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerDao.SellerNo(seller_id);
		
		// 견적서 저장하고
		sellerDao.CustomOrderInsert(customOrderDto);
		//		- 파일이 있으면 파일테이블에 등록
		
		// 견적서 저장 테이블 시퀀스 가져오기
		int custom_order_no = sellerDao.CustomSeq();
		
		// 견적서 관리 테이블에 판매자번호, 견적서 번호 등록
		sellerCustomDto = SellerCustomOrderDto.builder()
																		.custom_order_no(custom_order_no)
																		.seller_no(seller_no)
																		.build();
		sellerDao.SellerCustom(sellerCustomDto);
		return null;
	}

}
