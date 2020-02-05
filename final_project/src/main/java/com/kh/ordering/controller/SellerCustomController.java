package com.kh.ordering.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.service.MemberCustomService;
import com.kh.ordering.service.SellerCustomService;

@Controller
@RequestMapping("/seller")
public class SellerCustomController {
	
// 판매자 주문제작 요청서 작성
	@GetMapping("/customOrder")
	public String memberCustom() {
		return "seller/customOrder";
	}
		
	@Autowired
	private SellerCustomService sellerCustomService;
		
	@PostMapping("/customOrder")
	public String memberCustom(HttpSession session,
												CustomOrderDto customOrderDto,
												SellerCustomOrderDto sellerCustomDto) {
			
		String id = "seller";
		session.setAttribute("seller_id", id);
		
		sellerCustomService.SellerCustom(session, customOrderDto, sellerCustomDto);
		
		return "redirect:/seller/customOrder";
	}
}
