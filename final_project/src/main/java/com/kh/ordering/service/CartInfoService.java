package com.kh.ordering.service;

import com.kh.ordering.vo.PagingVO;

public interface CartInfoService {

//	회원 주문내역 페이징
	PagingVO cartInfoPaging(String pageNo, int member_no);
}
