package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.AdminQnaDto;
import com.kh.ordering.vo.PagingVO;

@Repository
public class AdminQnaDaoImpl implements AdminQnaDao{

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private AdminQnaDao adminQnaDao;


	@Override
	public List<AdminQnaDto> getListReport(PagingVO pagingVO) {

		List<AdminQnaDto> reportlist =sqlSession.selectList("adminQnaDto.getListReport",pagingVO);
		return  reportlist;
	}

	@Override
	public int countBoard(int member_no) {

		return sqlSession.selectOne("adminQnaDto.countBoard",member_no);
	}

	@Override
	public AdminQnaDto qnaBoardGetOne(AdminQnaDto adminQnaDto) {
		AdminQnaDto result = sqlSession.selectOne("adminQnaDto.adminQnaGetOne", adminQnaDto);
		return result;
	}

	@Override
	public int countqna(int member_no) {
		return sqlSession.selectOne("adminQnaDto.countqna",member_no);
	}

	@Override
	public List<AdminQnaDto> getListQna(PagingVO pagingVO) {
		List<AdminQnaDto> qnalist = sqlSession.selectList("adminQnaDto.getListQna",pagingVO);
		return qnalist;
	}

	@Override
	public AdminQnaDto qnaGetOne(AdminQnaDto adminQnaDto) {
		AdminQnaDto result1 = sqlSession.selectOne("adminQnaDto.QnaGetOne", adminQnaDto);
		return result1;
	}

	@Override
	public int QnaSeq() {
		return sqlSession.selectOne("adminQnaDto.QnaSeq");
	}

	@Override
	public void qnaregist(AdminQnaDto adminQnaDto) {
		sqlSession.insert("adminQnaDto.qnaregist", adminQnaDto);
	}

	@Override
	public void qnaUpdate(AdminQnaDto adminQnaDto) {
		sqlSession.update("adminQnaDto.qnaUpdate", adminQnaDto);

	}

//	@Override
//	public AdminQnaDto qnagetupdate(AdminQnaDto adminQnaDto) {
//		AdminQnaDto result = sqlSession.selectOne("adminQnaDto.qnagetupdate");
//		return result;
//	}

	@Override
	public AdminQnaDto qnagetUpdate(int admin_qna_no) {
		AdminQnaDto  result = sqlSession.selectOne("adminQnaDto.qnagetUpdate", admin_qna_no);
		return result;
	}





}