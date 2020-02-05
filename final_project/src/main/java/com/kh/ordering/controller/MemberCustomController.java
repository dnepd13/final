package com.kh.ordering.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.service.MemberCustomService;

@Controller
@RequestMapping("/member")
public class MemberCustomController {

// 멤버 주문제작 요청서 작성
	@GetMapping("/customOrder")
	public String memberCustom() {
		return "member/customOrder";
	}
	
	@Autowired
	private MemberCustomService memberCustomService;
	
	@PostMapping("/customOrder")
	public String memberCustom(HttpSession session,
												CustomOrderDto customOrderDto,
												MemberCustomOrderDto memberCustomDto) {
		
		String id = "member";
		session.setAttribute("member_id", id);
		
		memberCustomService.MemberCustom(session, customOrderDto, memberCustomDto);
		
		return "redirect:/member/customOrder";
	}
}
