package com.kh.ordering.repository;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;

import com.kh.ordering.entity.SellerCustomOrderDto;

import com.kh.ordering.entity.SellerDto;

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
	
	//판매자 비밀번호 번경
	void change_pw(SellerDto sellerDto);
//	SellerDto change_pw(SellerDto sellerDto);
	
//판매자 아이디 중복검사
	int id_check(String seller_id);
	
	//판매자 아이디 찾기
	SellerDto find_id(SellerDto sellerDto);
	

		
		

	


// 판매자 번호로 단일조회
	SellerDto sellerDto(int seller_no);
	
	
// 신고 문의 게시판 영역 
	
////판매자 세션에 있는 id를 통해 번호 구하기 
	int getSellerNo(String seller_id);
	int getNo(String seller_id);





}
