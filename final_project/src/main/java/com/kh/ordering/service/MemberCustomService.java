package com.kh.ordering.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.SellerAlarmDto;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.SellerDao;

@Service
public class MemberCustomService implements MemberService{
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private SellerDao sellerDao;
	
	@Override
	public CustomOrderDto MemberCustom(HttpSession session,
																	CustomOrderDto customOrderDto,
																	MemberCustomOrderDto memberCustomDto,
																	SellerAlarmDto sellerAlarmDto) {
		
		// 회원번호를 구해오고
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.MemberNo(member_id);
		
		// 요청서를 저장 테이블에 저장한 뒤
		memberDao.CustomOrderInsert(customOrderDto);
		//		 - 파일이 있으면 파일테이블에 등록
		
		
		// 요청서 저장 테이블 시퀀스 가져오기
		int custom_order_no = memberDao.CustomSeq();
		
		// 요청서 관리 테이블에 회원번호, 요청서 번호 등록
		memberCustomDto = MemberCustomOrderDto.builder()
																				.custom_order_no(custom_order_no) // 요청서 번호
																				.member_no(member_no) // 회원번호
																				.build();
		memberDao.MemberCustom(memberCustomDto);
		
		// 판매자에게 요청서 도착 알람 생성
		int seller_no = 2; // 판매자 번호. 나중에 상품/판매자 기능쪽에서 가져오기.
		sellerAlarmDto = SellerAlarmDto.builder()
															.seller_no(seller_no)
															.member_custom_order_no(custom_order_no)
															.build();
		sellerDao.CustomAlarmInsert(sellerAlarmDto);
		return null;
	}
}
