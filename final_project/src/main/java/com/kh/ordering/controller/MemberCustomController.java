package com.kh.ordering.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberAlarmDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.SellerAlarmDto;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.service.MemberCustomServiceImpl;
import com.kh.ordering.vo.CustomOrderVO;

@Controller
@RequestMapping("/member")
public class MemberCustomController {
	
	@Autowired
	private MemberCustomServiceImpl memberCustomServiceImpl;
	
	@Autowired
	private MemberDao memberDao;

// 멤버 주문제작 요청서 작성 페이지
	@GetMapping("/customOrder")
	public String memberCustom() {
		return "member/customOrder";
	}
	
	@PostMapping("/customOrder")
	public String memberCustom(HttpSession session,
												CustomOrderDto customOrderDto,
												MemberCustomOrderDto memberCustomDto,
												SellerAlarmDto sellerAlarmDto) {
		
		//로그인을 가정한 세션설정. 로그인 유지기능 완료 후 수정하기
		String member_id = "cool121";
		session.setAttribute("member_id", member_id);
		
		// 구매자 요청서 보내기
		// 요청서 작성 --> 주문제작 테이블 데이터 입력 --> 관리테이블 데이터 등록 --> 판매자 알람 테이블 등록
		memberCustomServiceImpl.MemberCustom(session, customOrderDto, memberCustomDto, sellerAlarmDto);
		
		return "redirect:/member/customList";
	}
	
	// 구매자가 받은 견적서 및 보낸 요청서 목록 페이지
	@GetMapping("/customList")
	public String memberCustomList(Model model, HttpSession session) {
		String id = "member";
		session.setAttribute("member_id", id);
		
		// 모든 견적서
		model.addAttribute("getListCustom", memberDao.getListCustom());
		
		// 내가 보낸 요청서
		// 나중에 세션 ID 수정하기
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);
		
		model.addAttribute("getListReq", memberDao.getListReq(member_no));
		return "member/customList";
	}
// 받은 견적서 상세 페이지
	@GetMapping("/customInfo")
	public String memberCustomContent(int custom_order_no, Model model) {
		
		CustomOrderVO content = memberDao.customOrderVO(custom_order_no);
		model.addAttribute("getCustomInfo", content);
		
		return "member/customInfoResp";
	}

}
