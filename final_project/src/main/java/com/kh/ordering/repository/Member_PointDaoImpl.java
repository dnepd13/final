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
	public void registsuccess(Member_PointDto member_PointDto) {
		sqlSession.insert("member_pointDto.regist", member_PointDto);
		
	}

}
