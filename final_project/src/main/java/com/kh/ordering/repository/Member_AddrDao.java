package com.kh.ordering.repository;


import java.util.List;

import com.kh.ordering.entity.Member_AddrDto;

public interface Member_AddrDao {

	
	//구해온 번호로 배송지 추가
	void insertaddr(Member_AddrDto member_AddrDto);

	List<Member_AddrDto> getListAddr(int member_no);
	
//	//배송지 정보조회
//	Member_AddrDto addrinfo(Member_AddrDto member_AddrDto);
	
}
