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
	
	//새글쓰기
	@Override
	public void qnaBoardInsertNew(AdminQnaBoardDto adminQnaBoardDto) {
		sqlSession.insert("admin.adminQnaNewWrite", adminQnaBoardDto);
	}

	@Override
	public void qnaBoardInsertSecond(AdminQnaBoardDto adminQnaBoardDto) {
		sqlSession.insert("admin.adminQnaSecondWrite", adminQnaBoardDto);
	}

	@Override
	public void qnaBoardUpdate(AdminQnaBoardDto adminQnaBoardDto) {
		sqlSession.update("admin.qnaBoardUpdate", adminQnaBoardDto);	
	}

	@Override
	public void qnaBoardDelete(AdminQnaBoardDto adminQnaBoardDto) {
		sqlSession.delete("admin.qnaBoardDelete", adminQnaBoardDto);
	}

	@Override
	public int qnaBoardTitleCount(String admin_qna_title) {
		return sqlSession.selectOne("admin.adminQnaTitleCount", admin_qna_title);
	}

	@Override
	public int qnaBoardHeadCount(String admin_qna_head) {
		return sqlSession.selectOne("admin.adminQnaHeadCount", admin_qna_head);
	}

	
}
