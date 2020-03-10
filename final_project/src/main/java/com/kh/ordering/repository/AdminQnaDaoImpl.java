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


	@Override
	public AdminQnaDto qnagetUpdate(int admin_qna_no) {
		AdminQnaDto  result = sqlSession.selectOne("adminQnaDto.qnagetUpdate", admin_qna_no);
		return result;
	}

	@Override
	public void deleteqna(AdminQnaDto adminQnaDto) {
		sqlSession.delete("adminQnaDto.deleteqna", adminQnaDto);
	}

	@Override
	public void reportregist(AdminQnaDto adminQnaDto) {
		sqlSession.insert("adminQnaDto.reportregist", adminQnaDto);
		
		}

	@Override
	public List<AdminQnaDto> getListSellerQna(PagingVO pagingVO) {
		List<AdminQnaDto> qnasellerlist = sqlSession.selectList("adminQnaDto.getListSellerQna",pagingVO);
		return qnasellerlist;
	}

	@Override
	public List<AdminQnaDto> getListSellerReport(PagingVO pagingVO) {
		List<AdminQnaDto> sellerreportlist =sqlSession.selectList("adminQnaDto.getListSellerReport",pagingVO);
		return  sellerreportlist;
	}

	@Override
	public int countsellerqna(int seller_no) {
		return sqlSession.selectOne("adminQnaDto.countsellerqna",seller_no);
	}

	@Override
	public int countSellerBoard(int seller_no) {
		return sqlSession.selectOne("adminQnaDto.countSellerBoard",seller_no);
	}

	@Override
	public AdminQnaDto reportgetupdate(int admin_qna_no) {
		AdminQnaDto  result = sqlSession.selectOne("adminQnaDto.reportgetupdate",admin_qna_no);
		return result;
	}

	@Override
	public void reportUpdate(AdminQnaDto adminQnaDto) {
		sqlSession.update("adminQnaDto.reportUpdate", adminQnaDto);

	}

	@Override
	public AdminQnaDto ReportGetOne(AdminQnaDto adminQnaDto) {
		AdminQnaDto result1 = sqlSession.selectOne("adminQnaDto.ReportGetOne", adminQnaDto);
		return result1;
	}

	@Override
	public void sellerqnaregist(AdminQnaDto adminQnaDto) {
		sqlSession.insert("adminQnaDto.sellerqnaregist", adminQnaDto);
	}

	@Override
	public AdminQnaDto sellerqnaGetOne(AdminQnaDto adminQnaDto) {
		AdminQnaDto result1 = sqlSession.selectOne("adminQnaDto.sellerQnaGetOne", adminQnaDto);
		return result1;
	}

	@Override
	public AdminQnaDto sellerqnagetUpdate(int admin_qna_no) {
		AdminQnaDto result = sqlSession.selectOne("adminQnaDto.sellerqnagetUpdate", admin_qna_no);
		return result;
	}

	@Override
	public void sellerqnaUpdate(AdminQnaDto adminQnaDto) {
		sqlSession.update("adminQnaDto.sellerqnaUpdate", adminQnaDto);

	}

	@Override
	public void sellerreportregist(AdminQnaDto adminQnaDto) {
		sqlSession.insert("adminQnaDto.sellerreportregist", adminQnaDto);
	}

	@Override
	public AdminQnaDto sellerreportGetOne(AdminQnaDto adminQnaDto) {
		AdminQnaDto result1 = sqlSession.selectOne("adminQnaDto.sellerreportGetOne", adminQnaDto);
		return result1;
	}

	@Override
	public AdminQnaDto sellerreportgetupdate(int admin_qna_no) {
		AdminQnaDto  result = sqlSession.selectOne("adminQnaDto.sellerreportgetupdate",admin_qna_no);
		return result;
	}

	@Override
	public void sellerreportUpdate(AdminQnaDto adminQnaDto) {
		sqlSession.update("adminQnaDto.sellerreportUpdate", adminQnaDto);

		}

	
	// 최근 3일기준 관리자 문의게시판 작성 List	
	@Override
	public List<AdminQnaDto> getListYesterDay(PagingVO paging) {
		return sqlSession.selectList("adminQnaDto.getListYesterDay", paging);
	}
	@Override
	public int getYesterDayCount(int member_no) {
		return sqlSession.selectOne("adminQnaDto.getYesterDayCount", member_no);
	}





}