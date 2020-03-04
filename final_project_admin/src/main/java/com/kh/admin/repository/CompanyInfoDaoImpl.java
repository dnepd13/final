package com.kh.admin.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.CompanyInfoDto;

@Repository
public class CompanyInfoDaoImpl implements CompanyInfoDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public CompanyInfoDto get() {
		return sqlSession.selectOne("admin.getCompanyInfo");
	}

	@Override
	public void update(CompanyInfoDto companyInfoDto) {
		sqlSession.update("admin.updateCompanyInfo", companyInfoDto);
	}
	
}
