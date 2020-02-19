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
import com.kh.admin.repository.SalesDao;
import com.kh.admin.service.ChartService;
import com.kh.admin.vo.ConnectListVO;
import com.kh.admin.vo.ConnectVO;

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
		
		return "sales/status";
	}
	
	@GetMapping("/data")
	@ResponseBody
	public JSONObject data() {
		
		JSONObject data = chartService.dailyVisitChart();
		
		return data;

	}
	
}
