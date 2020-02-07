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
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.SellerCustomServiceImpl;
import com.kh.ordering.vo.CustomOrderVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/seller")
@Slf4j
public class SellerCustomController {
	
	@Autowired
	private SellerCustomServiceImpl sellerCustomService;
	
	@Autowired
	private SellerDao sellerDao;
	
// 판매자 주문제작 견적서 작성 페이지
	@GetMapping("/customOrder")
	public String memberCustom() {
		return "seller/customOrder";
	}
		
	@PostMapping("/customOrder")
	public String memberCustom(HttpSession session, int seller_no,
												CustomOrderDto customOrderDto,
												SellerCustomOrderDto sellerCustomDto,
												MemberAlarmDto memberAlarmDto) {
		
		//로그인을 가정한 세션설정. 로그인 유지기능 완료 후 수정하기
		String seller_id = "11";
		session.setAttribute("seller_id", seller_id);
		
		//판매자 견적서 보내기
		//견적서 작성 --> 주문제작 테이블 데이터 입력 --> 관리테이블 데이터 등록 --> 구매자 알람 테이블 등록
		sellerCustomService.SellerCustom(session, seller_no, customOrderDto, sellerCustomDto, memberAlarmDto);
		
		return "redirect:/seller/customList";
	}
	
// 팬매자가 받은 요청서 및 견적서 목록 페이지
	@GetMapping("/customList")
	public String getListCustom(Model model, HttpSession session) {
		String id = "11";
		session.setAttribute("seller_id", id);
		
		// 모든 요청서
		model.addAttribute("getListCustom", sellerDao.getListCustom());
		
		// 내가 보낸 견적서
		// 나중에 세션 ID 수정하기
		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerDao.getNo(seller_id);
		
		model.addAttribute("getListResp", sellerDao.getListResp(seller_no));
		
		return "seller/customList";
	}
// 받은 요청서 상세 페이지
	@GetMapping("/customInfoReq")
	public String memberCustomContent(int custom_order_no, Model model) {
		
		CustomOrderVO content = sellerDao.customOrderVO(custom_order_no);

		model.addAttribute("getCustomInfo", content);
		
		return "seller/customInfoReq";
	}
}
