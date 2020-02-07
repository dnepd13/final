package com.kh.ordering.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.SellerDao;

@Service
public class SellerCustomServiceImpl implements SellerCustomService{
	
	@Autowired
	private SellerDao sellerDao;
	@Autowired
	private MemberDao memberDao;

	@Override
	public CustomOrderDto SellerCustom(HttpSession session, int seller_no,
																CustomOrderDto customOrderDto,
																SellerCustomOrderDto sellerCustomDto,
																MemberAlarmDto memberAlarmDto) {
		
//		// 세션에서 판매자 번호 구하고
//		String seller_id = (String)session.getAttribute("seller_id");
//		seller_no = sellerDao.getNo(seller_id);
		
		// 견적서 저장하고
		sellerDao.CustomOrderInsert(customOrderDto);
		//		- 파일이 있으면 파일테이블에 등록
		
		// 견적서 저장 테이블 시퀀스 가져오기
		int custom_order_no = sellerDao.CustomSeq();
		
		// 견적서 관리 테이블에 판매자번호, 견적서 번호 등록
		sellerCustomDto = SellerCustomOrderDto.builder()
																		.custom_order_no(custom_order_no)
																		.seller_no(seller_no)
																		.build();
		sellerDao.SellerCustom(sellerCustomDto);
		
		//구매자에게 견적서 도착 알람 생성
		// - 구매자 ID 통해서 구매자 회원번호 가져오기
		String member_id = "member"; // 세션 임의설정
		session.setAttribute("member_id", member_id);
		
		int member_no = memberDao.getNo(member_id);
		memberAlarmDto = MemberAlarmDto.builder()
																		.member_no(member_no)
																		.seller_custom_order_no(custom_order_no)
																		.build();
		memberDao.CustomAlarmInsert(memberAlarmDto);
		return null;
	}

	
}
