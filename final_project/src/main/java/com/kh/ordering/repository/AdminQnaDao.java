package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.AdminQnaDto;
import com.kh.ordering.vo.PagingVO;

public interface AdminQnaDao {

	//신고 게시판
	List<AdminQnaDto> getListReport(PagingVO pagingVO);

	public int countBoard(int member_no);

	public AdminQnaDto qnaBoardGetOne(AdminQnaDto adminQnaDto);

	//문의 게시판
	public int countqna(int member_no);

	List<AdminQnaDto> getListQna(PagingVO pagingVO);

	public AdminQnaDto qnaGetOne(AdminQnaDto adminQnaDto);

	int QnaSeq();

	void qnaregist(AdminQnaDto adminQnaDto);

	public void qnaUpdate(AdminQnaDto adminQnaDto);

	public AdminQnaDto qnagetUpdate(int admin_qna_no);

	void deleteqna(AdminQnaDto adminQnaDto);





//	public int countBoard();


}