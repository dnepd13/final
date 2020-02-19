package com.kh.ordering.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ordering.repository.DeliveryDao;
import com.kh.ordering.repository.GoodsOptionDao;
import com.kh.ordering.service.GoodsOptionService;
import com.kh.ordering.vo.CartVO;
import com.kh.ordering.vo.ItemVOList;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	@Autowired
	private DeliveryDao deliveryDao;
	
	@Autowired
	private GoodsOptionService goodsOptionService;
	
	@PostMapping("/order")
	public String order(@ModelAttribute ItemVOList itemVOList, Model model) throws JsonProcessingException {
		List<CartVO> cartVOList = goodsOptionService.getCartVOList(itemVOList.getItemVOList());
		// 상품 1개 배송 정보
		// 배송 정보 리스트로 보내야 함
		model.addAttribute("deliveryDto", deliveryDao.get2(cartVOList.get(0).getGoodsDto().getGoods_no()));
		model.addAttribute("cartVOList", cartVOList);
		
		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("jsonCartVOList", mapper.writeValueAsString(cartVOList));
		
		return "order/order";
	}
	
}
