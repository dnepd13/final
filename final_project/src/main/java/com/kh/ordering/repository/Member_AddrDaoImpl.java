package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;


import com.kh.ordering.entity.Member_AddrDto;

public class Member_AddrDaoImpl implements Member_AddrDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertaddr(Member_AddrDto member_AddrDto) {
		
		//번호 추출
		sqlSession.insert("member_AddrDto.insertaddr", member_AddrDto);
	}

	@Override
	public List<Member_AddrDto> getListAddr(int member_no) {
		
		return sqlSession.selectList("member_AddrDto.getListAddr", member_no);
	}

	@Override
	public Member_AddrDto addrGetOne(Member_AddrDto member_AddrDto) {
		Member_AddrDto result = sqlSession.selectOne("member_AddrDto.addrGetOne", member_AddrDto);
		return result;
	}

	@Override
	public void addredit(Member_AddrDto member_AddrDto) {
		sqlSession.update("member_AddrDto.addredit", member_AddrDto);
		
	}

	@Override
	public Member_AddrDto addrgetUpdate(int member_addr_no) {
		Member_AddrDto result = sqlSession.selectOne("member_AddrDto.addrgetUpdate", member_addr_no);
				return result;
	}

	@Override
	public void addrUpdate(Member_AddrDto member_AddrDto) {
		sqlSession.update("member_AddrDto.addrUpdate", member_AddrDto);
	}

	@Override
	public void addrregist(Member_AddrDto member_AddrDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Member_AddrDto getBasicAddr(int member_no) {
		return sqlSession.selectOne("member_AddrDto.getBasicAddr", member_no);
	}
	
	//추가 배송지 작성
	@Override
	public void insertchuaddr(Member_AddrDto member_AddrDto) {
		//번호 추출
		sqlSession.insert("member_AddrDto.insertchuaddr", member_AddrDto);
	}


	
	
	
	

//	@Override
//	public Member_AddrDto addrinfo(Member_AddrDto member_AddrDto) {
//		Member_AddrDto addrinfo = sqlSession.selectOne("member_AddrDto.addrinfo", member_AddrDto);
//		return member_AddrDto;
//	}

	
	


//	@Override
//	public MemberDto getNo(int member_no) {
//		return sqlSession.selectOne("member_no.getNo",member_no);
//	}

}