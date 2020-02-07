package com.kh.ordering.controller;
import java.util.*;
import java.text.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.SellerService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/seller")
public class SellerController {
	@Autowired
	private SellerService sellerService;
	//회원가입 전 이용약관동의 받기
	@GetMapping("/regist_agree")
	public String regist_agree() {	  
		
		return "seller/regist_agree";
	}
	@PostMapping("/regist_agree")
	public String regist_agree(@ModelAttribute SellerDto sellerDto, Model model) {
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd hh:mm:ss", Locale.KOREA );
		Date currentTime = new Date ( );
		String dTime = formatter.format ( currentTime );
//		System.out.println ( dTime );
		model.addAttribute("dTime",dTime);
		
		return "redirect:/seller/regist";
	}
	
	//판매자 회원가입
	@GetMapping("/regist")
	public String regist() {
		return "seller/regist";	
	}
	@Autowired
	private PasswordEncoder encoder;//password는bcrypt의 상위개념
	@PostMapping("/regist")
	public String regist(@ModelAttribute SellerDto sellerDto) {
		//sellerDto에 들어잇는 pw를 암호화 한다(bcrypt)
		
//		 String origin= sellerDto.getSeller_pw();
//		 String result = encoder.encode(origin);
//		 sellerDto.setSeller_pw(result);
		
		sellerDto.setSeller_pw(encoder.encode(sellerDto.getSeller_pw()));
		sellerService.regist(sellerDto);
	//	return"redirect:/seller/regist_success";
		return"redirect:/seller/regist_success";
	}
	@GetMapping("/regist_success")
	public String regist_success() {
		return "seller/regist_success";
	}
//가입완료후 페이지
//	@PostMapping("/regist_success")
//	private String regist_success(@ModelAttribute SellerDto sellerDto) {
//		return "redirect:seller/regist_success";
//	}
	
	//판매자 로그인
	@GetMapping("/login")
	private String login( ) {
		return "seller/login";
		
	}
	@PostMapping("/login")
	private String login(@ModelAttribute SellerDto sellerDto) {
		//비밀번호 암호화
		//아이디 검색을 하고 결과 유무 확인
			SellerDto find = sellerService.login(sellerDto);
//			log.info("id={}",find);
//			log.info("sellerDto={}",sellerDto);
		if(find == null) {
//			log.info("asd={}",find);
				return "redirect:/seller/login?error";
		}
		else {//id가  잇으면--->비밀번호 매칭검사
			boolean correct =encoder.matches(sellerDto.getSeller_pw(),find.getSeller_pw());
//			boolean correct = sellerDto.getSeller_pw().equals(find.getSeller_pw());
//			log.info("current={}",correct);
					if(correct == true) {   //비밀번호일치
						return "redirect:/";				
					}
					else {
//						log.info("asda");
						return "redirect:/seller/login?error";
					}
			
		}
	}
	
}
