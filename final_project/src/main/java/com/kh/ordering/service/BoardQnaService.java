package com.kh.ordering.service;



import com.kh.ordering.vo.PagingVO;

public interface BoardQnaService {

	//회원 문의게시판 
	public PagingVO adminQnaPagination(String pno1 , int member_no);

	public PagingVO QnaPagination(String pno1, int member_no);



}