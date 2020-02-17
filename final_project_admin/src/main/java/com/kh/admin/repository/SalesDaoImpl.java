package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.vo.ConnectListVO;
import com.kh.admin.vo.ConnectVO;

@Repository
public class SalesDaoImpl implements SalesDao{

	@Autowired
	private SqlSession sqlSession;
	@Override
	public List<ConnectListVO> connectList() {
		
		return sqlSession.selectList("admin.userDaily");
	}

}
