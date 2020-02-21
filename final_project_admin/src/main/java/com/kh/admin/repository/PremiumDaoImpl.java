package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.PremiumDto;

@Repository
public class PremiumDaoImpl implements PremiumDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<PremiumDto> premiumGetList() {
		List<PremiumDto> list = sqlSession.selectList("admin.premiumGetList");
		return list;
	}

	@Override
	public void premiumInsert(PremiumDto premiumDto) {
		sqlSession.insert("admin.premiumInsert", premiumDto);
	}

	@Override
	public void premiumUpdate(PremiumDto premiumDto) {
		sqlSession.update("admin.premiumUpdate", premiumDto);
	}

	@Override
	public void premiumDelete(PremiumDto premiumDto) {
		sqlSession.delete("admin.premiumDelete", premiumDto);
	}

	@Override
	public List<PremiumDto> getPremium() {
		return sqlSession.selectList("admin.getPremium");
	}

	@Override
	public int calculratePremium(int total) {
		return sqlSession.selectOne("admin.calculratePremium", total);
	}
	
	
}
