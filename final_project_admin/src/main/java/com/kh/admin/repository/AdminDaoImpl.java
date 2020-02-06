package com.kh.admin.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.AdminDto;

@Repository
public class AdminDaoImpl implements AdminDao{

	@Autowired
	private SqlSession sqlSession;
	
	//로그인
	@Override
	public AdminDto login(AdminDto adminDto) {
		AdminDto login = sqlSession.selectOne("admin.getId", adminDto);
		return login;
	}

	//관리자 가입
	@Override
	public void regist(AdminDto adminDto) {
		sqlSession.insert("admin.insert", adminDto);
	}

	//최종로그인일시변동
	@Override
	public void lastLogin(AdminDto adminDto) {
		sqlSession.update("admin.lastLogin", adminDto);
	}
	
	
}
