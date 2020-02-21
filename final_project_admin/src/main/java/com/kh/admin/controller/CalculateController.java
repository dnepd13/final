package com.kh.admin.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.admin.repository.CalculateDao;
import com.kh.admin.repository.PremiumDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.service.CalculrateService;
import com.kh.admin.vo.CalculateVO;
import com.kh.admin.vo.FinalCalculateVO;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/calculate")
@Slf4j
public class CalculateController {
	
	@Autowired
	private CalculateDao calculateDao;
	
	@Autowired
	private PremiumDao premiumDao;
	
	@Autowired
	private CalculrateService calculrateService;
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping("total")
	public String total(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute PagingVO paging
			) {
		
		List<String> name = calculateDao.sellerTotalCollect();
		int count = name.size();
		
		PagingVO vo = boardService.allPaging(pno1,count);
		
		List<FinalCalculateVO> finish = calculrateService.calculrate(vo);
		model.addAttribute("cal", finish);
		model.addAttribute("paging", vo);
		return "calculate/total";
	}
}
