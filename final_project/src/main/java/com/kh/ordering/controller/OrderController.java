package com.kh.ordering.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.entity.Member_AddrDto;
import com.kh.ordering.repository.DeliveryDao;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.GoodsOptionDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.Member_AddrDao;
import com.kh.ordering.service.GoodsOptionService;
import com.kh.ordering.vo.CartVO;
import com.kh.ordering.vo.ItemVOList;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	@Autowired
	private DeliveryDao deliveryDao;
	
	@Autowired
	private GoodsOptionService goodsOptionService;
	
	@Autowired
	private HttpSession session;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private Member_AddrDao memberAddrDao;
	
	@PostMapping("/order")
	public String order(@ModelAttribute ItemVOList itemVOList, Model model, HttpSession session) throws JsonProcessingException {
		log.info("컨트롤러에서itemVOList={}",itemVOList.getItemVOList());
		List<CartVO> cartVOList = goodsOptionService.getCartVOList(itemVOList.getItemVOList());
		// 상품 1개 배송 정보
		// 배송 정보 리스트로 보내야 함
		model.addAttribute("deliveryDto", deliveryDao.get2(cartVOList.get(0).getGoodsDto().getGoods_no()));
		model.addAttribute("cartVOList", cartVOList);
		
		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("jsonCartVOList", mapper.writeValueAsString(cartVOList));
		
		String member_id = (String)session.getAttribute("member_id");
		
		// 포인트
		if(member_id != null) {
			model.addAttribute("user_point", memberDao.getPoint(member_id));
		} else {
			model.addAttribute("user_point", 0);
		}
		
		// 파일
		List<Integer> filesList = new ArrayList<>();
		for (CartVO cartVO : cartVOList) {
			filesList.add(goodsDao.getGoodsMainImage(cartVO.getGoodsDto().getGoods_no()));
		}
		model.addAttribute("filesList", filesList);
		
		return "order/order";
	}
	
	@PostMapping("/custom")
	public String custom(Model model) {
		
		// 회원번호, 회원정보 찾기
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);
		MemberDto member = memberDao.getMember(member_no);
		model.addAttribute("member", member);
		
		Member_AddrDto memberAddr = memberAddrDao.getBasicAddr(member_no);
		model.addAttribute("memberAddr", memberAddr);
		
//		// 회원 포인트 확인(사용가능 포인트)
//		int memberPoint = memberDao.getPoint(member_no);
//		model.addAttribute("memberPoint", memberPoint);
		
		return "order/custom";
	}
	
}
