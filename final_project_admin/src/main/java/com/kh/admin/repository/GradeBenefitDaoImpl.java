package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.GradeBenefitDto;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class GradeBenefitDaoImpl implements GradeBenefitDao{
	@Autowired
	private SqlSession sqlSession;
	@Override
	public void gradeBenefitRegist(GradeBenefitDto gradeBenefitDto) {
		sqlSession.insert("admin.gradeBenefitRegist", gradeBenefitDto);
	}
	@Override
	public List<GradeBenefitDto> gradeBenefitList() {
		return sqlSession.selectList("admin.gradeBenefitList");
	}
	@Override
	public void gradeBenefitUpdate(GradeBenefitDto gradeBenefitDto) {
		sqlSession.update("admin.gradeBenefitUpdate", gradeBenefitDto);
	}
	@Override
	public void gradeBenefitDelete(GradeBenefitDto gradeBenefitDto) {
		sqlSession.delete("admin.gradeBenefitDelete", gradeBenefitDto);
	}
	

}
