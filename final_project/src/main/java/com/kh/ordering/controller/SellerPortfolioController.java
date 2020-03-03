package com.kh.ordering.controller;

import java.util.List;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.SellerService;
import com.kh.ordering.vo.FilesVO;

@Controller
@RequestMapping("/seller")
public class SellerPortfolioController {
	@Autowired SellerDto sellerDto;
	@Autowired SellerDao sellerDao;
	@Autowired FilesDao filesDao;
	@Autowired FilesDto filesDto;
	
	//판매자 포토폴리오 등록
@GetMapping("/portfolio_insert")
public String portfolio(){
	return "/seller/portfolio";
	
}
//파일 넘버는 파일 테이블에서 가져온다,샐러 넘버는샐러 카고리에서 가져온다
	//판매자 포토폴리오 등록  5장까지 등록할 수 있음
@PostMapping("/portfolio_insert")
public String portfolio(@RequestParam MultipartFile file,@ModelAttribute FilesVO filesVO,@ModelAttribute SellerDto sellerDtro,@ModelAttribute FilesDto filesDto) {
	 int seller_no=sellerDao.getSequence();
	 
	// List<integer> list = SellerService.insertportfolio(seller_portfolio_image,seller_no,files_no);
	      
		return "redirect:/seller/main";
		
}
}
