package com.kh.admin.service;

import com.kh.admin.vo.PagingVO;

public interface BoardService {
	public PagingVO pagination(String pno1);	
	public PagingVO sellerPagination(String pno1);
	public PagingVO categoryPagination(String pno1);
	public PagingVO memberPagination(String pno1);
	public PagingVO adminQnaPagination(String pno1);
}
