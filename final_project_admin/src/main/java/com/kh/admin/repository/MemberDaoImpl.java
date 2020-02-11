package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.MemberDto;
import com.kh.admin.vo.PagingVO;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int memberCount() {
		int result = sqlSession.selectOne("admin.memberCount");
		return result;
	}

	@Override
	public List<MemberDto> memberGetList(PagingVO vo) {
		List<MemberDto> list = sqlSession.selectList("admin.memberGetList", vo);
		return list;
	}

}
