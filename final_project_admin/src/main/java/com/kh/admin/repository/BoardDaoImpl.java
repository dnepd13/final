package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.AdminQnaBoardDto;
import com.kh.admin.vo.PagingVO;

@Repository
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int adminQnaCount() {
		int result = sqlSession.selectOne("admin.adminQnaCount");
		return result;
	}

	@Override
	public List<AdminQnaBoardDto> qnaBoardGetList(PagingVO vo) {
		List<AdminQnaBoardDto> list = sqlSession.selectList("admin.adminQnaGetList", vo);
		
		return list;
	}

	@Override
	public AdminQnaBoardDto qnaBoardGetOne(AdminQnaBoardDto adminQnaBoardDto) {
		AdminQnaBoardDto result = sqlSession.selectOne("admin.adminQnaGetOne", adminQnaBoardDto);
		return result;
	}

	
}
