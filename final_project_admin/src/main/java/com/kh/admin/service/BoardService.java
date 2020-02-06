package com.kh.admin.service;

import com.kh.admin.vo.PagingVO;

public interface BoardService {
	public PagingVO pagination(String pno1);	
	public PagingVO sellerPagination(String pno1);
}
