package com.kh.ordering.repository;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.vo.CustomOrderVO;

public interface SellerDao {
	int getSequence();
	void regist(SellerDto sellerDto);
	//////판매자 로그인//////
	SellerDto login(SellerDto sellerDto);
	/////판매자 정보조회////
	SellerDto info(SellerDto sellerDto);
	//판매자 정보 수정//////
	SellerDto info_edit(SellerDto sellerDto);
	
	//판매자 회원탈퇴
	void delete(SellerDto sellerDto);
	void changepw(SellerDto sellerDto);
	

		int id_check(String seller_id);





}
