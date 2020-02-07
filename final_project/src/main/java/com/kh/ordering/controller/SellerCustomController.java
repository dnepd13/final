package com.kh.ordering.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.SellerCustomService;
import com.kh.ordering.vo.CustomOrderVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/seller")
@Slf4j
public class SellerCustomController {
	
	@Autowired
	private SellerCustomService sellerCustomService;
	
	@Autowired
	private SellerDao sellerDao;
	
// 판매자 주문제작 요청서 작성 페이지
	@GetMapping("/customOrder")
	public String memberCustom() {
		return "seller/customOrder";
	}
		
	@PostMapping("/customOrder")
	public String memberCustom(HttpSession session, String seller_id,
												CustomOrderDto customOrderDto,
												SellerCustomOrderDto sellerCustomDto) {
			
		session.setAttribute("seller_id", seller_id);
		
		sellerCustomService.SellerCustom(session, customOrderDto, sellerCustomDto);
		
		return "redirect:/seller/customList";
	}
	
// 판매자가 받은 요청서 및 견적서 목록 페이지
	@GetMapping("/customList")
	public String getListCustom(Model model, HttpSession session) {
		String id = "seller2";
		session.setAttribute("seller_id", id);
		
		// 모든 요청서
		model.addAttribute("getListCustom", sellerDao.getListCustom());
		
		// 내가 보낸 견적서
		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerDao.SellerNo(seller_id);
		
		model.addAttribute("getListResp", sellerDao.getListResp(seller_no));
		
		return "seller/customList";
	}
// 받은 요청서 상세 페이지
	@GetMapping("/customContent")
	public String memberCustomContent(int custom_order_no, Model model) {
		
		CustomOrderVO content = sellerDao.customOrderVO(custom_order_no);
		log.info("content={}", content);
		model.addAttribute("getCustomContent", content);
		
		return "seller/customContent";
	}
}
