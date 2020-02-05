package com.kh.ordering.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.SellerDao;
@Service
public class SellerServiceImpl  implements SellerService{
@Autowired
private SellerDao sellerDao;

	@Override
	public void regist(SellerDto sellerDto) {
		//등록을 위한 정보 생성
		// - 등록에 앞서서 회원번호를 먼저 구해온다
		
		//판매자 번호 추출
				int seller_no = sellerDao.getSequence();
				
				//판매자 회원 등록
				sellerDto.setSeller_no(seller_no);
				sellerDao.regist(sellerDto);
	}

}
