package com.kh.ordering.repository;


import java.util.List;

import com.kh.ordering.entity.Member_AddrDto;

public interface Member_AddrDao {

	
	//구해온 번호로 배송지 추가
	void insertaddr(Member_AddrDto member_AddrDto);

	//전체 배송지 조회
	List<Member_AddrDto> getListAddr(int member_no);

	// 1개에 대한 배송지 조회
	public Member_AddrDto addrGetOne(Member_AddrDto member_AddrDto);
	
	//배송지 정보 수정
	public void addredit(Member_AddrDto member_AddrDto);

	public Member_AddrDto addrgetUpdate(int member_addr_no);

	public void addrUpdate(Member_AddrDto member_AddrDto);

	void addrregist(Member_AddrDto member_AddrDto);

	// 기본주소만 조회
	public Member_AddrDto getBasicAddr(int member_no);

	void insertchuaddr(Member_AddrDto member_AddrDto);


	
//	//배송지 정보조회
//	Member_AddrDto addrinfo(Member_AddrDto member_AddrDto);
	
}