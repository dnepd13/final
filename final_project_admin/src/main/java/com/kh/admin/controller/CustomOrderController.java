package com.kh.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.admin.entity.FilesDto;
import com.kh.admin.repository.CustomOrderDao;
import com.kh.admin.repository.GoodsFilesDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.vo.CustomOrderVO;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/custom")
@Slf4j
public class CustomOrderController {
	@Autowired
	private CustomOrderDao customorderDao;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private GoodsFilesDao goodsFilesDao;
	
	@GetMapping("list")
	public String list(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute PagingVO paging
			) {
		log.info("1번");
		int count;
		count = customorderDao.getCustomOrderCount(paging);
		PagingVO vo = boardService.allPaging(pno1, count);
		log.info("2번={}",vo);
		vo.setKey(paging.getKey());
		vo.setSearch(paging.getSearch());
		List<CustomOrderVO> list = customorderDao.getList(vo);
		log.info("list={}",list);
		model.addAttribute("paging", vo);
		model.addAttribute("list", list);
		return "custom/list";
	}
	
	@GetMapping("/detail")
	public String detail(
			Model model,
			@RequestParam int custom_order_no
			) {
		log.info("no={}",custom_order_no);
		CustomOrderVO vo = customorderDao.getOne(custom_order_no);
		log.info("vo={}", vo);
		model.addAttribute("list", vo);
		
		List<FilesDto> file = goodsFilesDao.getCustomOrderFiles(custom_order_no);
		
		model.addAttribute("file", file);
		
		return "custom/detail";
	}
}
