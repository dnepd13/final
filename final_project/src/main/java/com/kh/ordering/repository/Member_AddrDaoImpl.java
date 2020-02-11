package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;


import com.kh.ordering.entity.Member_AddrDto;

public class Member_AddrDaoImpl implements Member_AddrDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void registaddr(Member_AddrDto member_AddrDto) {
		
		//번호 추출
		sqlSession.insert("member_AddrDto.insertaddr", member_AddrDto);
	}

	
	


//	@Override
//	public MemberDto getNo(int member_no) {
//		return sqlSession.selectOne("member_no.getNo",member_no);
//	}

}
