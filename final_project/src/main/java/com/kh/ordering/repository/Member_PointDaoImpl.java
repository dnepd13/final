package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.Member_PointDto;

@Repository
public class Member_PointDaoImpl implements Member_PointDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int MemberGetSeq() {
		
		return sqlSession.selectOne("member_PointDto.MemberGetSeq");
	}

	@Override
	public void pointregist(Member_PointDto member_PointDto) {
		sqlSession.insert("member_PointDto.pointregist", member_PointDto);
		
	}

	@Override
	public void registsuccess(Member_PointDto member_pointDto) {
		// TODO Auto-generated method stub
		
	}
	


}
