package com.kh.ordering.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.SellerAlarmDto;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.service.MemberCustomService;

@Controller
@RequestMapping("/member")
public class MemberCustomController {

// 멤버 주문제작 요청서 작성 페이지
	@GetMapping("/customOrder")
	public String memberCustom() {
		return "member/customOrder";
	}
	
	@Autowired
	private MemberCustomService memberCustomService;
	
	@PostMapping("/customOrder")
	public String memberCustom(HttpSession session, String member_id,
												CustomOrderDto customOrderDto,
												MemberCustomOrderDto memberCustomDto,
												SellerAlarmDto sellerAlarmDto) {
		
		session.setAttribute("member_id", member_id);
		
		// 요청서 작성 --> 주문제작 테이블 데이터 입력 --> 관리테이블 데이터 등록 --> 판매자 알람 테이블 등록
		memberCustomService.MemberCustom(session, customOrderDto, memberCustomDto, sellerAlarmDto);
		
		return "redirect:/member/customList";
	}
	
	@Autowired
	private MemberDao memberDao;
	
	// 구매자가 받은 견적서 및 보낸 요청서 목록 페이지
	@GetMapping("/customList")
	public String memberCustomList(Model model, HttpSession session) {
		String id = "member";
		session.setAttribute("member_id", id);
		
		// 모든 견적서
		model.addAttribute("getListCustom", memberDao.getListCustom());
		
		// 내가 보낸 요청서
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberDao.MemberNo(member_id);
		
		model.addAttribute("getListReq", memberDao.getListReq(member_no));
		return "member/customList";
	}

}
