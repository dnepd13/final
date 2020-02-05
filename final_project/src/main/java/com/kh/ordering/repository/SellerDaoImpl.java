package com.kh.ordering.repository;

import java.lang.reflect.Member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.SellerDto;
@Repository
public class SellerDaoImpl implements SellerDao {
@Autowired
private SqlSession sqlSession;

	@Override
	public int getSequence() {
		int result = sqlSession.selectOne("seller.sequence");
		return result;
	}

	@Override
	public void regist(SellerDto sellerDto) {
		sqlSession.insert("seller.insert",sellerDto);
	
	}

		
}
