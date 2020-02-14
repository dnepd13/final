package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.vo.VisitCountVO;

@Repository
public class VisitCountDaoImpl implements VisitCountDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public void insertVisitor() {
		sqlSession.insert("visit.visitCount");
		
	}
}
