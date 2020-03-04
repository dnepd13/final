package com.kh.ordering.controller;

import java.net.URISyntaxException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.GoodsOptionDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.OrderDao;
import com.kh.ordering.repository.PayDao;
import com.kh.ordering.service.payService;
import com.kh.ordering.vo.CartVO;
import com.kh.ordering.vo.KakaoPayReadyReturnVO;
import com.kh.ordering.vo.KakaoPayReadyVO;
import com.kh.ordering.vo.KakaoPayRevokeReturnVO;
import com.kh.ordering.vo.KakaoPaySuccessReadyVO;
import com.kh.ordering.vo.KakaoPaySuccessReturnVO;
import com.kh.ordering.vo.OrderVO;
import com.kh.ordering.vo.PayReadyReturnVO;

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/pay/kakao")
@Slf4j
public class KakaoPayController {

	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private payService payService;
	
	@Autowired
	private PayDao payDao;
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private MemberDao memberDao;
	
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
			) throws Exception {
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
		
		 payService.transactionOrder(data.getPartner_order_id());
		 
		 return "redirect:/pay/success";
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("list", payDao.getList());
		return "pay/list";
	}
	
	@GetMapping("/revoke")
	public String revoke(@RequestParam int ordering_no) {
		
		try {
			KakaoPayRevokeReturnVO vo = payService.revoke(ordering_no);
			return "redirect:/pay/kakao/cancel";
	
		} catch (URISyntaxException e) {
			e.printStackTrace();
			return "redirect:/pay/kakao/list";

		}
		
		
	}
	
	@GetMapping("/cancel")
	public String cancel() {
		return "pay/cancel";
	}
	
//////////주문제작
//	결제준비 요청-응답
	@PostMapping("/customPay")
	public String customPay(@RequestParam String jsonOrderVO, HttpSession session) throws URISyntaxException, JsonMappingException, JsonProcessingException {
		
		// 결제준비 요청 데이터(뷰에서 넘어온 jsonOrderVO)를 받아서 카카오페이 요청 데이터에 set
		KakaoPayReadyVO readyVO = payService.setCustomReadyVO(jsonOrderVO);
		
		// Service에 넘기면 결제 준비 응답 데이터를 반환
		// 결제 준비 응답 데이터를 ReadyReturnVO 객체에 저장
		KakaoPayReadyReturnVO result = (KakaoPayReadyReturnVO) payService.readyReturnVO(readyVO, session, jsonOrderVO);
		
		// DB에 필요한 내역을 저장하고 성공페이지에 전달할 세션 추가
		session.setAttribute("tid", result.getTid()); // 응답의 tid
		session.setAttribute("readyVO", readyVO); // 결제요청 데이터
		
		// 응답 데이터 중 결제를 위한 주소가 들어있는 페이지로 redirect
		return "redirect:"+result.getNext_redirect_pc_url();
	}
	
	@GetMapping("/customPaySuccess")
	public String customPaySuccess(@RequestParam String pg_token, HttpSession session,
																Model model) throws Exception {
		String tid = (String)session.getAttribute("tid");
		KakaoPayReadyVO readyVO = (KakaoPayReadyVO) session.getAttribute("readyVO");
		
		session.removeAttribute("tid");
		session.removeAttribute("readyVO");
		
		// 결제 승인처리
		// KakaoPaySuccessReadyVO를 받아서 KakaoPaySuccessReturnVO 반환
		KakaoPaySuccessReadyVO successReadyVO
									= KakaoPaySuccessReadyVO.builder()
																					.cid("TC0ONETIME")
																					.tid(tid)
																					.partner_order_id(readyVO.getPartner_order_id())
																					.partner_user_id(readyVO.getPartner_user_id())
																					.pg_token(pg_token)
																					.build();

		KakaoPaySuccessReturnVO result = payService.approveVO(successReadyVO, session);

		payService.transactionOrder(successReadyVO.getPartner_order_id());
		
		log.info("주문번호partner_order_id={}", readyVO.getPartner_order_id());
		model.addAttribute("patner_order_id", readyVO.getPartner_order_id());
		
		return "pay/customPaySuccess";
	}
	@GetMapping("/customPayCancel")
	public String customPayCancel(){
		return "pay/customPayCancel";
	}
}
