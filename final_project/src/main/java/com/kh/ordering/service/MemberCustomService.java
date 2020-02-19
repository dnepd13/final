package com.kh.ordering.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

//	회원 요청서 Service
public interface MemberCustomService {	
	// 요청서 작성
	CustomOrderDto MemberCustom(HttpSession session, int seller_no,
																FilesVO files,
																CustomOrderDto customOrderDto,
																SellerCustomAlarmDto sellerCustomAlarmDto)
																throws IllegalStateException, IOException;
	// 요청서 파일 no 가져오기
	List<FilesVO> filesList(int member_custom_order_no);
	
	// 카테고리로 요청서 작성하기
	CustomOrderDto customCate(int category_no, HttpSession session,
														CustomOrderDto customOrderDto, FilesVO files)
														throws IllegalStateException, IOException;
	
	// 보낸 요청서 목록 내비게이터
	PagingVO customReqPaging(String pageNo, int member_no);
	// 받은 견적서 목록 내비게이터
	PagingVO customRespPaging(String pageNo, int member_no);
}
