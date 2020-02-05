package com.kh.ordering.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.service.GoodsService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/goods")
@Slf4j
public class GoodsController {
	
	@Autowired
	private GoodsService goodsService;
	
	@GetMapping("/insert")
	public String insert() {
		return "goods/insert";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute GoodsDto goodsDto) {
		return "redirect:get?goods_no=" + goodsService.insert(goodsDto);
	}
	
	@GetMapping("/get")
	public String get(@RequestParam int goods_no, Model model) {
		model.addAttribute("goodsDto", goodsService.get(goods_no));
		return "goods/get";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam int goods_no) {
		goodsService.delete(goods_no);
		return "redirect:list";
	}
	
	@GetMapping("/getList")
	public String getList(Model model) {
		model.addAttribute("list", goodsService.getList());
		return "goods/getList";
	}
}
