package com.kh.admin.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.admin.repository.CalculateDao;
import com.kh.admin.repository.PremiumDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.service.CalculrateService;
import com.kh.admin.vo.AdjustmentFullVO;
import com.kh.admin.vo.AdjustmentInsertVO;
import com.kh.admin.vo.AdjustmentVO;
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
			@ModelAttribute AdjustmentInsertVO adjustmentInsertVO,
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute PagingVO paging
			) {
		log.info("v111o={}",paging);
		int count = calculateDao.calculateCount(adjustmentInsertVO);
		log.info("count={}", count);
		PagingVO vo = boardService.allPaging(pno1, count);
		log.info("vo123={}", vo);
		vo.setYear(adjustmentInsertVO.getYear());
		vo.setMonth(adjustmentInsertVO.getMonth());
		vo.setSeller_id(adjustmentInsertVO.getSeller_id());
		model.addAttribute("paging", vo);
		List<AdjustmentVO> list = calculrateService.getCalculSeller(vo);
		model.addAttribute("list", list);
		
		return "calculate/total";
	}
	
	@GetMapping("/detail")
	public String detail(
			Model model,
			@ModelAttribute AdjustmentInsertVO adjustmentInsertVO,
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute PagingVO paging
			) {
		int count = calculateDao.oneSellerCount(adjustmentInsertVO);
		
		PagingVO vo = boardService.allPaging(pno1, count);
		model.addAttribute("paging", vo);
		vo.setYear(adjustmentInsertVO.getYear());
		vo.setMonth(adjustmentInsertVO.getMonth());
		vo.setSeller_id(adjustmentInsertVO.getSeller_id());
		log.info("getonevo={}",vo);
		List<AdjustmentFullVO> list = calculateDao.getOneSeller(vo);
		
		model.addAttribute("list", list);
		return "calculate/detail";
	}
}
