package com.kh.ordering.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.repository.MemberDao;

@Service
public class MemberCustomService implements MemberService{
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public CustomOrderDto MemberCustom(HttpSession session,
																	CustomOrderDto customOrderDto,
																	MemberCustomOrderDto memberCustomDto) {
		
		// 회원번호를 구해오고
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.MemberNo(member_id);
		
		// 요청서를 저장한 뒤
		memberDao.CustomOrderInsert(customOrderDto);
		//		 - 파일이 있으면 파일테이블에 등록
		
		
		// 요청서 저장 테이블 시퀀스 가져오기
		int custom_order_no = memberDao.CustomSeq();
		
		// 요청서 관리 테이블에 회원번호, 요청서 번호 등록
		memberCustomDto = MemberCustomOrderDto.builder()
																				.custom_order_no(custom_order_no)
																				.member_no(member_no)
																				.build();
		memberDao.MemberCustom(memberCustomDto);
		return null;
	}
}
