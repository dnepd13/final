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

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.OrderDao;
import com.kh.ordering.service.GoodsReviewService;
import com.kh.ordering.vo.FilesVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class GoodsReviewController {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private GoodsReviewService goodsReviewService;
	
	@GetMapping("/orderingList")
	public String orderingList(HttpSession session, Model model) {
		
		//주문정보 cart_info 정보 넘기기
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);
		
		List<CartInfoDto> cartInfoDto = memberDao.getCartList(member_no);
		model.addAttribute("getCartList", cartInfoDto);
		
		return "member/orderingList";
	}
	@PostMapping("/insertReview")
	public String insertReview(HttpSession session, FilesVO files,
													@RequestParam int cart_info_no,
													@ModelAttribute GoodsReviewDto goodsReviewDto)
													throws IllegalStateException, IOException {

		goodsReviewService.insertReview(session, files, cart_info_no, goodsReviewDto);
		
		return "redirect:/member/orderingList";
	}
}
