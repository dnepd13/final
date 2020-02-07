package com.kh.ordering.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.SellerCustomDao;

@Service
public class MemberCustomServiceImpl implements MemberCustomService{
	@Autowired
	private MemberCustomDao memberCustomDao;
	@Autowired
	private SellerCustomDao sellerCustomDao;
	
	@Override
	public CustomOrderDto MemberCustom(HttpSession session, int seller_no,
																	CustomOrderDto customOrderDto,
																	MemberCustomOrderDto memberCustomDto,
																	SellerCustomAlarmDto sellerCustomAlarmDto) {
		
		// 회원번호를 구해오고
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		// 요청서를 저장 테이블에 저장한 뒤
		memberCustomDao.CustomOrderInsert(customOrderDto);
		//		 - 파일이 있으면 파일테이블에 등록
		
		
		// 요청서 저장 테이블 시퀀스 가져오기
		int custom_order_no = memberCustomDao.CustomSeq();
		
		// 요청서 관리 테이블에 회원번호, 요청서 번호 등록
		memberCustomDto = MemberCustomOrderDto.builder()
																				.custom_order_no(custom_order_no) // 요청서 번호
																				.member_no(member_no) // 회원번호
																				.build();
		memberCustomDao.MemberCustom(memberCustomDto);
		
		// 판매자에게 요청서 도착 알람 생성
		//	- 판매자 ID 통해서 판매자 회원번호 가져오기.
		// - 나중에 사용자 클릭하면 파라미터 값으로 가져오기.
//		String seller_id = "11"; // 세션 임의설정
//		session.setAttribute("seller_id", seller_id);
		
//		seller_no = sellerCustomDao.getNo(seller_id);
		sellerCustomAlarmDto = SellerCustomAlarmDto.builder()
																					.seller_no(seller_no)
																					.member_custom_order_no(custom_order_no)
																					.build();
		sellerCustomDao.CustomAlarmInsert(sellerCustomAlarmDto);
		return null;
	}
}
