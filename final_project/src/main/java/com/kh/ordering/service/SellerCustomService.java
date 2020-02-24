package com.kh.ordering.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

//	판매자 견적서 Service
public interface SellerCustomService {
	// 견적서 작성
	CustomOrderDto SellerCustom(HttpSession session, int member_no, int category_no,
													FilesVO files,
													CustomOrderDto customOrderDto) throws IllegalStateException, IOException;
	
	// 견적서 파일 no가져오기
	List<FilesVO> filesList(int seller_custom_order_no);
	
	// 받은 요청서 목록 내비게이터
	PagingVO customReqPaging(String pageNo, int seller_no);
	// 보낸 견적서 목록 내비게이터
	PagingVO customRespPaging(String pageNo, int seller_no);
}
