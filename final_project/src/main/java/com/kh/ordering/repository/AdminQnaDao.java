package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.AdminQnaDto;
import com.kh.ordering.vo.PagingVO;

public interface AdminQnaDao {

	//신고 게시판
	List<AdminQnaDto> getListReport(PagingVO pagingVO);

	public int countBoard(int member_no);

	public AdminQnaDto qnaBoardGetOne(AdminQnaDto adminQnaDto);

	//문의 게시판 페이징 
	public int countqna(int member_no);

	List<AdminQnaDto> getListQna(PagingVO pagingVO);

	public AdminQnaDto qnaGetOne(AdminQnaDto adminQnaDto, int getNo);

	int QnaSeq();

	void qnaregist(AdminQnaDto adminQnaDto);

	public void qnaUpdate(AdminQnaDto adminQnaDto);

	public AdminQnaDto qnagetUpdate(int admin_qna_no);

	void deleteqna(AdminQnaDto adminQnaDto);

	void reportregist(AdminQnaDto adminQnaDto);

	
	//회원 문의 게시판 
	List<AdminQnaDto> getListSellerQna(PagingVO pagingVO);

	List<AdminQnaDto> getListSellerReport(PagingVO pagingVO);

	//판매자 문의 게시판 페이징 
	public int countsellerqna(int seller_no);

	public int  countSellerBoard(int seller_no);

	AdminQnaDto reportgetupdate(int admin_qna_no);

	void reportUpdate(AdminQnaDto adminQnaDto);

	AdminQnaDto ReportGetOne(AdminQnaDto adminQnaDto);

	//판매자 문의 게시판 작성
	void sellerqnaregist(AdminQnaDto adminQnaDto);

	AdminQnaDto sellerqnaGetOne(AdminQnaDto adminQnaDto);

	AdminQnaDto sellerqnagetUpdate(int admin_qna_no);

	void sellerqnaUpdate(AdminQnaDto adminQnaDto);

	void sellerreportregist(AdminQnaDto adminQnaDto);

	AdminQnaDto sellerreportGetOne(AdminQnaDto adminQnaDto);

	AdminQnaDto sellerreportgetupdate(int admin_qna_no);

	void sellerreportUpdate(AdminQnaDto adminQnaDto);

	AdminQnaDto qnaonemember(AdminQnaDto adminQnaDto);


// 최근 3일기준 관리자 문의게시판 작성 List
	List<AdminQnaDto> getListYesterDay(PagingVO paging);
	int getYesterDayCount(int member_no);
	
//	public int countBoard();


}