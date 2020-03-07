package com.kh.ordering.controller;

import java.io.File;
import java.io.IOException;
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
import com.kh.ordering.entity.PortfolioDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.SellerCategoryDao;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.SellerService;
import com.kh.ordering.vo.FilesVO;

@Controller
@RequestMapping("/seller")
public class PortfolioController {
	@Autowired SellerDto sellerDto;
	@Autowired SellerDao sellerDao;
	@Autowired FilesDao filesDao;
	@Autowired FilesDto filesDto;
	@Autowired SellerCategoryDao sellerCategoryDao;
	@Autowired SellerService sellerService;
	
	//판매자 포토폴리오 등록
@GetMapping("/portfolio_insert")
public String portfolio_insert(){
	return "/seller/portfolio_insert";
	
}
//세션으로아이디를 받고 회번번호 꺼내오는거는seller_categorydo에 있음,
//파일을 등록한 후 파일 번호를 꺼내고 샐러 넘버와 파일넘버를 portfolioDto에 넣는다
	//판매자 포토폴리오 등록  5장까지 등록할 수 있음
@PostMapping("/portfolio_insert")
public String portfolio_insert(HttpSession session,
								@ModelAttribute FilesVO files,
								@ModelAttribute SellerDto sellerDto,				
								@ModelAttribute PortfolioDto portfolioDto)
										throws IllegalStateException,IOException {
		
           System.out.println(files);
	sellerService.Portfolio_insert(session,files,sellerDto,portfolioDto);
	 
	
	      return "redirect:/seller/main";
		
}
}
