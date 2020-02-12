package com.kh.ordering.controller;

import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartFile;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.service.SellerCustomService;
import com.kh.ordering.service.SellerCustomServiceImpl;
import com.kh.ordering.service.SellerService;
import com.kh.ordering.vo.CustomOrderVO;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/seller")
@Slf4j
public class SellerCustomController {
	
	@Autowired
	private SellerCustomService sellerCustomService;
	
	@Autowired
	private SellerCustomDao sellerCustomDao;
	
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
		return "redirect:/seller/customListResp";
	}
	
// 판매자가 받은 요청서 목록
	@GetMapping("/customListReq")
	public String getListCustomReq(Model model, HttpSession session,
														@RequestParam(value="pageNo", required=false, defaultValue = "0") String pageNo) {
		//로그인을 가정한 세션설정. 로그인 유지기능 완료 후 수정하기
		String id = "seller";
		session.setAttribute("seller_id", id);
		
		// 나중에 세션 ID 수정하기
		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerCustomDao.getNo(seller_id);

		PagingVO result= sellerCustomService.customReqPaging(pageNo, seller_no);
		
		model.addAttribute("paging", result);
		
		// 알람 check N count 개수
		model.addAttribute("customAlarm", sellerCustomDao.customAlarm());

		// 1:1 받은 요청서
		List<CustomOrderVO> list = sellerCustomDao.getListReq(result);
		model.addAttribute("getListReq", list);
	
		return "seller/customListReq";
	}
// 받은 요청서 상세 페이지
	@GetMapping("/customInfoReq")
	public String memberCustomContent(HttpSession session, int member_custom_order_no, Model model) {
		
		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerCustomDao.getNo(seller_id);
		
		// 판매자 알림 업데이트 후
		sellerCustomDao.UpdateAlarm(seller_no, member_custom_order_no);
		// 상세페이지 보기
		CustomOrderVO content = sellerCustomDao.customOrderVO1(member_custom_order_no);
		model.addAttribute("getListInfoReq", content);
		
		return "seller/customInfoReq";
	}
// 보낸 견적서 목록 
	@GetMapping("/customListResp")
	public String getListCustomMine(Model model, HttpSession session,
														@RequestParam(value="pageNo", required=false, defaultValue = "0") String pageNo) {
		//로그인을 가정한 세션설정. 로그인 유지기능 완료 후 수정하기
//		String id = "seller";
//		session.setAttribute("seller_id", id);
		
		// 나중에 세션 ID 수정하기
		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerCustomDao.getNo(seller_id);
		
		
		PagingVO result= sellerCustomService.customRespPaging(pageNo, seller_no);
		
		model.addAttribute("paging", result);
		
		// 알람 check N count 개수
//		int customAlarm = sellerCustomDao.customAlarm();
		model.addAttribute("customAlarm", sellerCustomDao.customAlarm());

		// 내가 보낸 견적서		
		List<CustomOrderVO> list = sellerCustomDao.getListResp(result);
		model.addAttribute("getListResp", list);
	
		return "seller/customListResp";
	}	
//	보낸 견적서 상세페이지
	@GetMapping("/customInfoResp")
	public String CustomMineInfo(int seller_custom_order_no, Model model) {
		
		CustomOrderVO content = sellerCustomDao.customOrderVO2(seller_custom_order_no);
		model.addAttribute("getListInfoResp", content);
		
		return "seller/customInfoResp";
	}
// 임시 세션 remove
	@GetMapping("/remove")
	public String remove(HttpSession session) {
		session.removeAttribute("seller_no");
		return "seller/customList";
	}
}
