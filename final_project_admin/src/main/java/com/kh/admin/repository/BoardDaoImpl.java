package com.kh.admin.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private SqlSession sqlSession;
	@Override
	public int getBoardList() {
		
		return sqlSession.selectOne("admin.getBoardListCnt");
	}

}
