package com.kh.ordering.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.service.SellerCustomServiceImpl;
import com.kh.ordering.vo.CustomOrderVO;
import com.kh.ordering.vo.FilesVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/seller")
@Slf4j
public class SellerCustomController {
	
	@Autowired
	private SellerCustomServiceImpl sellerCustomService;
	
	@Autowired
	private SellerCustomDao sellerCustomDao;
	@Autowired
	private MemberCustomDao memberCustomDao;
	
// 판매자 주문제작 견적서 작성 페이지
	@GetMapping("/customOrder")
	public String memberCustom(HttpSession session,
															@RequestParam int member_no,
															Model model) {
		
		model.addAttribute("member_no", member_no);
		
		return "seller/customOrder";
	}
		
	@PostMapping("/customOrder")
	public String memberCustom(HttpSession session,
														@RequestParam int member_no,
														@ModelAttribute FilesVO files,
														@ModelAttribute CustomOrderDto customOrderDto,
														@ModelAttribute SellerCustomOrderDto sellerCustomDto,
														@ModelAttribute MemberCustomAlarmDto memberCustomAlarmDto) throws IllegalStateException, IOException {
	
		//판매자 견적서 보내기
		//견적서 작성 --> 주문제작 테이블 데이터 입력 --> 관리테이블 데이터 등록 --> 구매자 알람 테이블 등록
		sellerCustomService.SellerCustom(session, member_no, files, customOrderDto, sellerCustomDto, memberCustomAlarmDto);
		return "redirect:/seller/customList";
	}
	
// 판매자가 받은 요청서 및 보낸 견적서 목록 페이지
	@GetMapping("/customList")
	public String getListCustom(Model model, HttpSession session) {
		//로그인을 가정한 세션설정. 로그인 유지기능 완료 후 수정하기
		String id = "seller";
		session.setAttribute("seller_id", id);
		
		// 나중에 세션 ID 수정하기
		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerCustomDao.getNo(seller_id);

		// 1:1 받은 요청서
		model.addAttribute("getListReq", sellerCustomDao.getListReq(seller_no));
		
		// 내가 보낸 견적서		
		model.addAttribute("getListResp", sellerCustomDao.getListResp(seller_no));
		
		return "seller/customList";
	}
// 받은 요청서 상세 페이지
	@GetMapping("/customInfoReq")
	public String memberCustomContent(HttpSession session, int member_custom_order_no, Model model) {
		
		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerCustomDao.getNo(seller_id);
		
		// 판매자 알림 업데이트 후
		sellerCustomDao.UpdateAlarm(seller_no, member_custom_order_no);
		// 상세페이지 보기
		CustomOrderVO content = sellerCustomDao.customOrderVO(member_custom_order_no);
		model.addAttribute("getListInfoReq", content);
		
		return "seller/customInfoReq";
	}
//	보낸 견적서 상세페이지
	@GetMapping("/customInfoResp")
	public String memberCustomReq(int custom_order_no, Model model) {
		
		CustomOrderVO content = memberCustomDao.customOrderVO(custom_order_no);
		model.addAttribute("getListInfoResp", content);
		
		return "seller/customInfoResp";
	}
}
