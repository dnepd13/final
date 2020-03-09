package com.kh.admin.controller;

import java.util.ArrayList;
import java.util.Calendar;
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
	
//		int year = Calendar.getInstance().get(Calendar.YEAR);
//		int month = (Calendar.getInstance().get(Calendar.MONTH));
//		model.addAttribute("year", year);
//		model.addAttribute("month", month+1);
//		if(adjustmentInsertVO.getYear()<1) {
//			adjustmentInsertVO.setYear(year);
//		}
//		if(adjustmentInsertVO.getMonth()<1) {
//			adjustmentInsertVO.setMonth(month);
//		}
		log.info("ajust={}", adjustmentInsertVO);
		
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
		
		int year = Calendar.getInstance().get(Calendar.YEAR);
		int month = (Calendar.getInstance().get(Calendar.MONTH));
		if(adjustmentInsertVO.getYear()<1) {
			adjustmentInsertVO.setYear(year);
		}
		if(adjustmentInsertVO.getMonth()<1) {
			adjustmentInsertVO.setMonth(month+1);
		}
		
		int count = calculateDao.oneSellerCount(adjustmentInsertVO);
		
		PagingVO vo = boardService.allPaging(pno1, count);
		model.addAttribute("paging", vo);
		vo.setYear(adjustmentInsertVO.getYear());
		vo.setMonth(adjustmentInsertVO.getMonth());
		vo.setSeller_id(adjustmentInsertVO.getSeller_id());
		log.info("getonevo={}",vo);
		List<AdjustmentFullVO> list = calculateDao.getOneSeller(vo);
		log.info("list={}", list);
		model.addAttribute("list", list);
		
		
		String bankcode = list.get(0).getSeller_bank_code();
		String bank = calculrateService.getBankName(bankcode);
		model.addAttribute("bankname", bank);
		model.addAttribute("sellername", list.get(0).getSeller_name());
		model.addAttribute("email", list.get(0).getSeller_email());
		model.addAttribute("phone", list.get(0).getSeller_phone());
		model.addAttribute("storename", list.get(0).getSeller_store_name());
		model.addAttribute("storephone", list.get(0).getSeller_store_phone());
		model.addAttribute("account", list.get(0).getSeller_bank_account());
		model.addAttribute("accountname", list.get(0).getSeller_bank_username());		
		return "calculate/detail";
		
	}
	
	
	
	
}
