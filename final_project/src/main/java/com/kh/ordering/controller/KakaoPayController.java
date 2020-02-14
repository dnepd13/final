package com.kh.ordering.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
			log.info("vo={}", vo);
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
