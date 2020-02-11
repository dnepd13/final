package com.kh.ordering.controller;


import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.service.MemberCustomService;
import com.kh.ordering.vo.CustomOrderVO;
import com.kh.ordering.vo.FilesVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberCustomController {
	
	@Autowired
	private MemberCustomService memberCustomService;
	
	@Autowired
	private MemberCustomDao memberCustomDao;
	
	@Autowired
	private SellerCustomDao sellerCustomDao;

// 멤버 주문제작 1:1 요청서 작성 페이지
//	- goodsInfo 페이지에서 접속 가능.
	@GetMapping("/customOrder")
	public String memberCustom(HttpSession session,
															@RequestParam int seller_no,
															Model model) {
		
		//로그인을 가정한 세션설정. 로그인 유지기능 완료 후 수정하기
//		String member_id = "member";
//		session.setAttribute("member_id", member_id);

		model.addAttribute("seller_no", seller_no);
		
		return "member/customOrder";
	}
	
	@PostMapping("/customOrder")
	public String memberCustom(HttpSession session, 
												@RequestParam int seller_no,
												@ModelAttribute FilesVO files,
												@ModelAttribute CustomOrderDto customOrderDto,
												@ModelAttribute SellerCustomAlarmDto sellerCustomAlarmDto) throws IllegalStateException, IOException {
		
		// 구매자 요청서 보내기
		// 요청서 작성 --> 주문제작 테이블 데이터 입력 --> 관리테이블 데이터 등록 --> 판매자 알람 테이블 등록
		memberCustomService.MemberCustom(session, seller_no,files, customOrderDto, sellerCustomAlarmDto);
		
		return "redirect:/member/customList";
	}
	
	// 구매자가 받은 견적서 및 보낸 요청서 목록 페이지
	@GetMapping("/customList")
	public String memberCustomList(Model model, HttpSession session) {
		// 나중에 세션 ID 수정하기
		String id = "member";
		session.setAttribute("member_id", id);
		
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		// 1:1 받은 견적서
		model.addAttribute("getListResp", memberCustomDao.getListResp(member_no));		
		
		// 내가 보낸 요청서		
		model.addAttribute("getListReq", memberCustomDao.getListReq(member_no));
		
		return "member/customList";
	}
// 받은 견적서 상세 페이지
	@GetMapping("/customInfoResp")
	public String memberCustomResp(HttpSession session,
																	@RequestParam int seller_custom_order_no, Model model) {
		// 상세페이지 이동하면 구매자 알람테이블의 '알람체크','알람 확인시간' update
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		memberCustomDao.UpdateAlarm(member_no, seller_custom_order_no);
		
		CustomOrderVO content = memberCustomDao.customOrderVO(seller_custom_order_no);
		model.addAttribute("getListInfoResp", content);
		
		session.removeAttribute("member_id");
		
		return "member/customInfoResp";
	}
//	보낸 요청서 상세페이지
	@GetMapping("/customInfoReq")
	public String memberCustomReq(int custom_order_no, Model model) {
		
		CustomOrderVO content = sellerCustomDao.customOrderVO(custom_order_no);
		model.addAttribute("getListInfoReq", content);
		
		return "member/customInfoReq";
	}
}
