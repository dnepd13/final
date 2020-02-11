package com.kh.ordering.repository;


import com.kh.ordering.entity.Member_AddrDto;

public interface Member_AddrDao {

	
	//구해온 번호로 배송지 추가
	void registaddr(Member_AddrDto member_AddrDto);
	
//	//번호
//	MemberDto getNo(int member_no);
	
}
