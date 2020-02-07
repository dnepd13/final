package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;
	

	@Override
	public int MemberSeq() {
		return sqlSession.selectOne("memberDto.MemberSeq");
	}

	@Override
	public void regist(MemberDto memberDto) {
		sqlSession.insert("memberDto.regist", memberDto); //세션값에 있는 regist를 저장
		
	}

	
	
	
//	@Override
//	public MemberDto getMemberDto(int seq) throws Exception {
//		
//		MemberDto memberDto = sqlSession.selectOne("getMemberDto", seq);
//		return memberDto;
//	}

//	@Override
//	public MemberDto login(MemberDto memberDto) {
//		
//		return sqlSession.selectOne("member.login", memberDto);
//	}


	
}
