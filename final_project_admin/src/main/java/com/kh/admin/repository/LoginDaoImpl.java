package com.kh.admin.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.AdminDto;

@Repository
public class LoginDaoImpl implements LoginDao{

	@Autowired
	private SqlSession sqlSession;
	@Override
	public AdminDto login(AdminDto adminDto) {
		AdminDto login = sqlSession.selectOne("admin.login", adminDto);
		return login;
	}

}
