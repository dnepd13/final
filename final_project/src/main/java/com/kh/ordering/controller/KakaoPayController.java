package com.kh.ordering.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.service.payService;
import com.kh.ordering.vo.KakaoPayReadyVO;
import com.kh.ordering.vo.PayReadyReturnVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/pay/kakao")
@Slf4j
public class KakaoPayController {
	
	@Autowired
	private payService payService;
	
	@GetMapping("/confirm")
	public String confirm() {
		return "pay/confirm";
	}
	
	@PostMapping("/confirm")
	public String confirm(
			@ModelAttribute KakaoPayReadyVO vo,
			HttpSession session
			) {
		try {
			PayReadyReturnVO result = payService.ready(vo);
			
			session.setAttribute("tid", result.getTid()); //trade id를 전달
			session.setAttribute("ready", vo);
		
		
			return "redirect:"+result.getNext_redirect_pc_url();
		} 
		catch (URISyntaxException e) {
			e.printStackTrace();
			return "redirect:/pay/confirm";
		}
		
	}
	
	@GetMapping("/success")
	public String success(
			@RequestParam String pg_token,
			HttpSession session,
			
			)
	
}
