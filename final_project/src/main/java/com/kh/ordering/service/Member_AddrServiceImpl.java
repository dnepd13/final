package com.kh.ordering.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.entity.Member_AddrDto;
import com.kh.ordering.repository.Member_AddrDao;

@Service
public class Member_AddrServiceImpl implements Member_AddrService{

	@Autowired
	private Member_AddrDao member_AddrDao;
	
//	@Override
//	public Member_AddrDto addrinfo(Member_AddrDto member_AddrDto) {
//
//		return member_AddrDao.addrinfo(member_AddrDto);
//	}

	
}
