package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.vo.ReviewVO;

@Repository
public class GoodsReviewDaoImpl implements GoodsReviewDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ReviewVO> reviewList(int no) {
		return sqlSession.selectList("admin.reviewList", no);
	}
	
}
