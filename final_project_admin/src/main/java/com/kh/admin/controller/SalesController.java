package com.kh.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.admin.entity.OrderingDto;
import com.kh.admin.repository.SalesDao;
import com.kh.admin.service.ChartService;
import com.kh.admin.vo.ConnectListVO;
import com.kh.admin.vo.ConnectVO;
import com.kh.admin.vo.MonthlySalePriceVO;
import com.kh.admin.vo.ResultVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/sales")
@Slf4j
public class SalesController {
	
	@Autowired
	private SalesDao salesDao;
	
	@Autowired
	private ChartService chartService;
	
	@GetMapping("/status")
	public String manage(Model model) {
		int a = 0;
		ResultVO result = salesDao.dailySalePrice();
		if(result != null) {
			model.addAttribute("dailySalePrice", result.getResult());
		}
		else {
			model.addAttribute("dailySalePrice", a);
		}
		
		ResultVO result1 =salesDao.todaySaleCount();
		if(result1 != null) {
			model.addAttribute("todaySaleCount", result1.getResult());
		}
		else {
			model.addAttribute("todaySaleCount", a);
		}
		
		ResultVO result2 = salesDao.thisMonthSalePrice();
		if(result2 != null) {
			model.addAttribute("thisMonthSalePrice", result2.getResult());
		}
		else {
			model.addAttribute("todaySaleCount", a);
		}
		
		ResultVO result3 = salesDao.thisMonthSaleCount();
		if(result3 != null) {
			model.addAttribute("thisMonthSaleCount", result3.getResult());
		}
		else {
			model.addAttribute("todaySaleCount", a);
		}
		
		ResultVO result4 = salesDao.thisWeekSalePrice();
		if(result4 != null) {
			model.addAttribute("thisWeekSalePrice", result4.getResult());
		}
		else {
			model.addAttribute("todaySaleCount", a);
		}
		
		ResultVO result5 = salesDao.thisWeekSaleCount();
		if(result5 != null) {
			model.addAttribute("thisWeekSaleCount", result5.getResult());
		}
		else {
			model.addAttribute("todaySaleCount", a);
		}
		
		//취소 오늘, 이번주, 이번달
		ResultVO result6 = salesDao.dailyCancel();
		if(result6 != null) {
			model.addAttribute("dailyCancel", result6.getResult());
		}
		else {
			model.addAttribute("dailyCancel", a);
		}
		
		ResultVO result7 = salesDao.thisWeekCancel();
		if(result7 != null) {
			model.addAttribute("thisWeekCancel", result7.getResult());
		}
		else {
			model.addAttribute("thisWeekCancel", a);
		}
		
		ResultVO result8 = salesDao.thisMonthCancel();
		if(result8 != null) {
			model.addAttribute("thisMonthCancel", result8.getResult());
		}
		else {
			model.addAttribute("thisMonthCancel", a);
		}
		return "sales/status";
	}
	//일일방문자
	@GetMapping("/data")
	@ResponseBody
	public JSONObject data() {
		
		JSONObject data = chartService.dailyVisitChart();
		
		return data;

	}
	//일일판매
	@GetMapping("/monthlySalePrice")
	@ResponseBody
	public JSONObject monthlySalePrice() {
		JSONObject data = chartService.monthlySalePriceChart();
		log.info("data={}", data);
		return data;
	}
	//상품 탑텐
	@GetMapping("/goodsTopTen")
	@ResponseBody
	public JSONObject goodsTopTen() {
		log.info("여기");
		JSONObject data = chartService.goodsTopTen();
		log.info("여기6");
		log.info("piedata={}", data);
		return data;
	}
	
	//금액별 탑텐
	@GetMapping("/priceTopTen")
	@ResponseBody
	public JSONObject priceTopTen() {
		JSONObject data = chartService.priceTopTen();
		return data;
	}
	
	//많이 판 판매자 탑텐
	@GetMapping("/sellerTopTen")
	@ResponseBody
	public JSONObject sellerTopTen() {
		JSONObject data = chartService.sellerTopTen();
		return data;
	}
}
