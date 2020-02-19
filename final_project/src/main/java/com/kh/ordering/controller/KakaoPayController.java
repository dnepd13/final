package com.kh.ordering.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.kh.ordering.repository.PayDao;
import com.kh.ordering.service.payService;
import com.kh.ordering.vo.KakaoPayReadyVO;
import com.kh.ordering.vo.KakaoPayRevokeReturnVO;
import com.kh.ordering.vo.KakaoPaySuccessReadyVO;
import com.kh.ordering.vo.KakaoPaySuccessReturnVO;
import com.kh.ordering.vo.PayReadyReturnVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/pay/kakao")
@Slf4j
public class KakaoPayController {
	
	@Autowired
	private payService payService;
	
	@Autowired
	private PayDao payDao;
	
	
	@PostMapping("/test")
	public String test(@RequestParam String orderVO, Model model) {
		model.addAttribute("orderVO", orderVO);
		return "pay/test";
	}
	
	@GetMapping("/confirm")
	public String confirm() {
		return "pay/confirm";
	}
	
	@PostMapping("/confirm")
	public String confirm(HttpSession session, @RequestParam String jsonOrderVO, Model model) throws JsonMappingException, JsonProcessingException {
		try {
			// 카카오페이 처리
			KakaoPayReadyVO kakaoPayReadyVO = payService.setReadyVO(jsonOrderVO);
			PayReadyReturnVO result = payService.ready(kakaoPayReadyVO, jsonOrderVO, session); // 결제준비정보+주문정보
			
			session.setAttribute("tid", result.getTid()); //trade id를 전달
			session.setAttribute("ready", kakaoPayReadyVO);
//			model.addAttribute("jsonOrder", jsonOrderVO);
			log.info("vo={}", kakaoPayReadyVO);
			log.info("주소={}", result.getNext_redirect_pc_url());
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
			Model model
			) {
		try {
		String tid = (String) session.getAttribute("tid");
		KakaoPayReadyVO vo = (KakaoPayReadyVO) session.getAttribute("ready");
		
		session.removeAttribute("tid");
		session.removeAttribute("ready");
		
		log.info("pg_token = {}", pg_token);
		log.info("tid = {}", tid);
		log.info("vo = {}", vo);
		
		KakaoPaySuccessReadyVO data = KakaoPaySuccessReadyVO.builder()
												.cid("TC0ONETIME")
												.tid(tid)
												.partner_order_id(vo.getPartner_order_id())
												.partner_user_id(vo.getPartner_user_id())
												.pg_token(pg_token)
											.build();

			KakaoPaySuccessReturnVO result = payService.approve(data);
			return "pay/success";
		} catch (URISyntaxException e) {
			e.printStackTrace();
			return "redirect:/pay/confirm";

		}
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("list", payDao.getList());
		return "pay/list";
	}
	
	@GetMapping("/revoke")
	public String revoke(@RequestParam int no) {
		
		try {
			KakaoPayRevokeReturnVO vo = payService.revoke(no);
			return "redirect:/pay/kakao/list";
	
		} catch (URISyntaxException e) {
			e.printStackTrace();
			return "redirect:/pay/kakao/list";

		}
		
		
	}
	
}
