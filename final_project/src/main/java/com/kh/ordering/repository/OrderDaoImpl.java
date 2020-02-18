package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.vo.OrderVO;

public class OrderDaoImpl implements OrderDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(OrderVO orderVO) {
		//분리
		
	}
}
