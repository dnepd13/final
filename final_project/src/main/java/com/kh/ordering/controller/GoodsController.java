package com.kh.ordering.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ordering.repository.CategoryDao;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.GoodsOptionDao;
import com.kh.ordering.service.DeliveryService;
import com.kh.ordering.service.GoodsService;
import com.kh.ordering.vo.DeliveryVO;
import com.kh.ordering.vo.GoodsVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/goods")
@Slf4j
public class GoodsController {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private DeliveryService deliveryService;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	
	@GetMapping("/insert")
	public String insert(Model model) {
		model.addAttribute("category_largeList", categoryDao.getList("category_large", "-"));
		return "goods/insert";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute GoodsVO goodsVO, @ModelAttribute DeliveryVO deliveryVO) {
		int goods_no = goodsService.insert(goodsVO);
		deliveryVO.setGoods_no(goods_no);
		deliveryService.insert(deliveryVO);
		return "redirect:goodsInfo?goods_no=" + goods_no;
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
	
	@GetMapping("/goodsInfo")
	public String goodsInfo(@RequestParam int goods_no, Model model) throws JsonProcessingException {
		String jsonGoodsVO = new ObjectMapper().writeValueAsString(goodsService.getGoodsVO(goods_no));
		String jsonGoodsOptionVOList = new ObjectMapper().writeValueAsString(goodsService.getGoodsOptionVOList(goods_no));
		
		model.addAttribute("goodsVO", goodsService.getGoodsVO(goods_no));
		model.addAttribute("goodsOptionVOList", goodsService.getGoodsOptionVOList(goods_no));
		model.addAttribute("jsonGoodsVO", jsonGoodsVO);
		model.addAttribute("jsonGoodsOptionVOList", jsonGoodsOptionVOList);
		
		return "goods/goodsInfo";
	}
	
	@PostMapping("/large")
	@ResponseBody
	public List<String> large(@RequestParam String category_name) {
		return categoryDao.getList("category_middle", category_name);
	}
	
	@PostMapping("/middle")
	@ResponseBody
	public List<String> middle(@RequestParam String category_name) {
		return categoryDao.getList("category_small", category_name);
	}
	
	@PostMapping("/small")
	@ResponseBody
	public int small(@RequestParam String category_name) {
		return categoryDao.get(category_name).getCategory_no();
	}

}
