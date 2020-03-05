package com.kh.ordering.service;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.PortfolioDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.vo.FilesVO;
public interface SellerService {
	//판매자 가입 Service
	void regist(SellerDto sellerDto);
	
	//판매자 로그인 Service
	SellerDto login(SellerDto sellerDto);
 
	//포트폴리오 작성
    PortfolioDto Portfolio_insert(HttpSession session,
 		                          FilesVO files,
 		                          SellerDto sellerDto,    		                        
 		                          PortfolioDto portfolioDto)
 		                          throws IllegalStateException,IOException;
    
	
}
