package com.kh.ordering.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.service.GoodsOptionService;

@Controller
@RequestMapping("/goods/goods_option")
public class GoodsOptionController {
	
	@Autowired
	private GoodsOptionService goodsOptionService;
	
//	@GetMapping("/insert")
//	public String insert() {
//		return "goods/goods_option/insert";
//	}
//	
//	@PostMapping("/insert")
//	public String insert(@ModelAttribute GoodsOptionDto goodsOptionDto) {
//		goodsOptionService.insert(goodsOptionDto);
//		return "redirect:getList";
//	}
	
//	@GetMapping("/delete")
//	public String delete(@RequestParam int goods_option_no) {
//		goodsOptionService.delete(goods_option_no);
//		return "redirect:getList";
//	}
//	
//	@GetMapping("/get")
//	public String get(@RequestParam int goods_option_no, Model model) {
//		model.addAttribute("goodsOptionDto", goodsOptionService.get(goods_option_no));
//		return "goods/goods_option/get";
//	}
//	
//	@GetMapping("/getList")
//	public String getList(Model model) {
//		model.addAttribute("list", goodsOptionService.getList());
//		return "goods/goods_option/getList";
//	}
}
