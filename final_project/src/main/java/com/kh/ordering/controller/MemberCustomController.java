package com.kh.ordering.controller;


import java.io.IOException;
import java.util.List;

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
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.service.MemberCustomService;
import com.kh.ordering.vo.CustomOrderVO;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

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
		
//		로그인을 가정한 세션설정. 로그인 유지기능 완료 후 수정하기
		String member_id = "member";
		session.setAttribute("member_id", member_id);

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
		
		return "redirect:/member/customListReq";
	}
	
	// 구매자가 받은 견적서 목록 페이지
	@GetMapping("/customListResp")
	public String getListCustomResp(Model model, HttpSession session,
																@RequestParam(value="pageNo", required=false, defaultValue="0") String pageNo) {
//		 나중에 세션 ID 수정하기
		String id = "member";
		session.setAttribute("member_id", id);
		
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		PagingVO result = memberCustomService.customRespPaging(pageNo, member_no);
		model.addAttribute("paging", result);
		
		// 알람 check N count 개수		
		model.addAttribute("customAlarm", memberCustomDao.customAlarm(member_no));

		// 1:1 받은 견적서
		List<CustomOrderVO> list = memberCustomDao.getListResp(result);
		model.addAttribute("getListResp", list);		
		
		return "member/customListResp";
	}
// 받은 견적서 상세 페이지
	@GetMapping("/customInfoResp")
	public String memberCustomResp(HttpSession session,
																	@RequestParam int seller_custom_order_no, Model model) {
		// 상세페이지 이동하면 구매자 알람테이블의 '알람체크','알람 확인시간' update
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		memberCustomDao.UpdateAlarm(member_no, seller_custom_order_no);
		
		CustomOrderVO content = memberCustomDao.customOrderVO1(seller_custom_order_no);
		model.addAttribute("getListInfoResp", content);
			
		return "member/customInfoResp";
	}

// 구매자가 보낸 요청서 목록 페이지
	@GetMapping("/customListReq")
	public String getListCustomReq(Model model, HttpSession session,
															@RequestParam(value="pageNo", required=false, defaultValue="0") String pageNo) {
//		 나중에 세션 ID 수정하기
		String id = "member";
		session.setAttribute("member_id", id);
		
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		PagingVO result = memberCustomService.customReqPaging(pageNo, member_no);
		model.addAttribute("paging", result);
		
		// 알람 check N count 개수		
		model.addAttribute("customAlarm", memberCustomDao.customAlarm(member_no));
		
		// 내가 보낸 요청서		
		List<CustomOrderDto> list = memberCustomDao.getListReq(result);
		model.addAttribute("getListReq", list);
		
		return "member/customListReq";
	}
//	보낸 요청서 상세페이지
	@GetMapping("/customInfoReq")
	public String memberCustomReq(int member_custom_order_no, Model model) {
		
		CustomOrderVO content = memberCustomDao.customOrderVO2(member_custom_order_no);
		model.addAttribute("getListInfoReq", content);
		
		return "member/customInfoReq";
	}
// 임시 세션 remove
	@GetMapping("/remove")
	public String remove(HttpSession session) {
		session.removeAttribute("member_no");
		return "redirect:/";
	}
}
