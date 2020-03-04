package com.kh.admin.controller;

import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.SellerDto;
import com.kh.admin.repository.CalculateDao;
import com.kh.admin.repository.SellerDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.service.EmailService;
import com.kh.admin.vo.BlockSellerVO;
import com.kh.admin.vo.CalculateVO;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/seller")
public class SellerController {
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private SellerDao sellerDao;
	
	@Autowired
	private CalculateDao calculateDao;
	
	@GetMapping("/manage")
	public String manage(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute PagingVO paging
			) {
		try {
			
		
		log.info("paging={}",paging);
		
		//검색을 위의 정보가 담긴 paging으로 해야한다
		//카운트를 구해서 같이 보내야한다
		//1번 검색어가 없을 경우
		int count;
		if(paging.getKey() == null) {
			log.info("1번입니다");
		count = sellerDao.sellerCount();
		PagingVO vo = boardService.allPaging(pno1, count);
		
		model.addAttribute("paging", vo);
		
		//판매자 리스트 불러오기
		List<BlockSellerVO> list = sellerDao.sellerGetList(vo);
		model.addAttribute("list", list);
		return "seller/manage";
		}
		
		//2번 검색어가 id일경우
		else if(paging.getKey().equalsIgnoreCase("seller_id")) {
			log.info("2번입니다");
			String seller_id = paging.getSearch();
			count = sellerDao.sellerIdCount(seller_id);
			PagingVO vo = boardService.allPaging(pno1, count);
			
			model.addAttribute("paging", vo);
			vo.setKey(paging.getKey());
			vo.setSearch(paging.getSearch());
			
			//판매자 리스트 불러오기
			List<BlockSellerVO> list = sellerDao.sellerGetList(vo);
			model.addAttribute("list", list);
			return "seller/manage";
			
		}
		
		else if(paging.getKey().equalsIgnoreCase("seller_grade")) {
			log.info("3번입니다");
			String seller_grade = paging.getSearch();
			count = sellerDao.sellerGradeCount(seller_grade);
			PagingVO vo = boardService.allPaging(pno1, count);
			
			model.addAttribute("paging", vo);
			vo.setKey(paging.getKey());
			vo.setSearch(paging.getSearch());
			
			//판매자 리스트 불러오기
			List<BlockSellerVO> list = sellerDao.sellerGetList(vo);
			log.info("list={}", list);
			model.addAttribute("list", list);
			return "seller/manage";
		}
		else {
			
			return "seller/manage";
		}
		} catch (Exception e) {
			e.printStackTrace();
			return "seller/manage";
		}
		
	}
	
	@PostMapping("/sellerpage")
	public String sellerpage(
			@RequestParam int seller_no,
			Model model
			) {
		try {
			
		SellerDto sellerDto = SellerDto.builder().seller_no(seller_no).build();
		SellerDto getOne = sellerDao.sellerGetOne(sellerDto);
		model.addAttribute("seller", getOne);
		return "seller/sellerpage";
		} catch (Exception e) {
			e.printStackTrace();
			return "seller/sellerpage";
		}
	}
	
	@GetMapping("/delete")
	public String selleredit(
			@ModelAttribute SellerDto sellerDto,
			Model model
			) {
		try {
			
		sellerDao.sellerDelete(sellerDto);
		return "redirect:/seller/manage";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/seller/manage";
		}
	}
	
	@PostMapping("/reset")
	public String reset(
			@RequestParam int seller_no,
			@RequestParam String seller_pw,
			@RequestParam String seller_email
			) {
		
		SellerDto sellerDto = SellerDto.builder()
									.seller_no(seller_no)
									.seller_pw(passwordEncoder.encode(seller_pw))
									.build();
		sellerDao.sellerChangePw(sellerDto);
		
		try {
			emailService.sendMessage(seller_email);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/seller/manage";
	}
	
	
}
