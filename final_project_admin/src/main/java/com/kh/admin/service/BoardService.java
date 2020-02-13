package com.kh.admin.service;

import com.kh.admin.vo.PagingVO;

public interface BoardService {
	public PagingVO pagination(String pno1);	
	public PagingVO categoryPagination(String pno1);
	public PagingVO adminQnaPagination(String pno1);
	public PagingVO pointPagination(String pno1, int member_no);
	public PagingVO blockPagination(String pno1);
	
	//총괄 paging하기
	public PagingVO allPaging(String pno1, int getCount);
}
