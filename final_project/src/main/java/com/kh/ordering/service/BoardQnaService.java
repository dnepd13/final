package com.kh.ordering.service;



import com.kh.ordering.vo.PagingVO;

public interface BoardQnaService {

	//회원 문의게시판 
	public PagingVO adminQnaPagination(String pno1 , int member_no);

	//회원 신고 게시판
	public PagingVO QnaPagination(String pno1, int member_no);
	
	//판매자 신고 게시판
	public PagingVO QnaPagination1(String pno2, int seller_no);

	public PagingVO adminQnaPagination1(String pno2, int seller_no);

	// 공지게시판
	PagingVO noticePaging(String paging);

	// 회원 마이페이지 메인 문의 페이징
	PagingVO myInfoQnaPaging(String paging, int member_no);
}