package com.kh.ordering.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	private GoodsOptionService goodsOptionService;
	
	@PostMapping("/order")
	public String order(@ModelAttribute ItemVOList itemVOList, Model model) {
		List<CartVO> cartVOList = goodsOptionService.getCartVOList(itemVOList.getItemVOList());
		model.addAttribute("cartVOList", cartVOList);
		return "order/order";
	}
	
}
