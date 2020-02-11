package com.kh.admin.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.CategoryDto;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
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
		log.info(adminDto.getAdmin_id());
		log.info(adminDto.getAdmin_grade());
		log.info(adminDto.getAdmin_email());
		log.info(adminDto.getAdmin_join_date());
		log.info(adminDto.getAdmin_last_login());
		log.info(adminDto.getAdmin_name());
		log.info(adminDto.getAdmin_pw());
		sqlSession.insert("admin.insert", adminDto);
	}

	//최종로그인일시변동
	@Override
	public void lastLogin(AdminDto adminDto) {
		sqlSession.update("admin.lastLogin", adminDto);
	}

	
	
	
}
