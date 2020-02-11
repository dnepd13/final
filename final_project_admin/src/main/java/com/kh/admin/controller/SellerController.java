package com.kh.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.SellerDto;
import com.kh.admin.repository.SellerDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/seller")
public class SellerController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private SellerDao sellerDao;
	
	@GetMapping("/manage")
	public String manage(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		PagingVO vo = boardService.sellerPagination(pno1);
		model.addAttribute("paging", vo);
		//판매자 리스트 불러오기
		List<SellerDto> list = sellerDao.sellerGetList(vo);
		model.addAttribute("list", list);
		return "seller/manage";
	}
	
	@PostMapping("/sellerpage")
	public String sellerpage(
			@RequestParam int seller_no,
			Model model
			) {
		SellerDto sellerDto = SellerDto.builder().seller_no(seller_no).build();
		SellerDto getOne = sellerDao.sellerGetOne(sellerDto);
		model.addAttribute("seller", getOne);
		return "seller/sellerpage";
	}
	
	@GetMapping("/delete")
	public String selleredit(
			@ModelAttribute SellerDto sellerDto,
			Model model
			) {
		sellerDao.sellerDelete(sellerDto);
		return "redirect:/seller/manage";
	}
}
