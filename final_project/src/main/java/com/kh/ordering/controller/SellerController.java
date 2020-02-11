package com.kh.ordering.controller;
import java.util.*;

import javax.servlet.http.HttpSession;

import java.text.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ordering.entity.SellerDto;

import com.kh.ordering.service.SellerService;

//import lombok.extern.slf4j.Slf4j;

@Controller
//@Slf4j
@RequestMapping("/seller")
public class SellerController {
	@Autowired
	private SellerService sellerService;
	
	//판매자 메인 홈
	@GetMapping("/main")
	public String main() {
		return "/seller/main";
	}
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
	@PostMapping("/regist_success")
	private String regist_success(@ModelAttribute SellerDto sellerDto) {
		return "redirect:seller/regist_success";
	}
	
	//판매자 로그인
	@GetMapping("/login")
	private String login( ) {
		return "seller/login";
		
	}
	@PostMapping("/login")
	private String login(@ModelAttribute SellerDto sellerDto, 
									HttpSession session) {
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
						session.setAttribute("seller_id", find.getSeller_id());
						return "redirect:/seller/main";				
					}
					else {
//						log.info("asda");
						return "redirect:/seller/login?error";
					}
			
		}
	}
//판매자 로그아웃 
	@GetMapping("/logout")
		public String logout(HttpSession session) {
		session.removeAttribute("seller_id");
		return "redirect:/";
	}
	// 판매자 관리 페이지
	@GetMapping("/management")
	 public String management() {
		return"seller/management";
	}
	@PostMapping("/management")
	public String management(@ModelAttribute SellerDto sellerDto ) {
		return"redirect:/seller/management";
	}
	//판매자 정보 조회
	@GetMapping("/info")
	public String info() {
		return "seller/info";
	}
	@PostMapping("/info")
	public String info(SellerDto sellerDto,Model model) {
		
		sellerService.info(sellerDto);
		return"redirect:/seller/info_edit";
	}
	//판매자 정보 수정
	@GetMapping("/info_edit")
	public String info_edit() {
		return "seller/info_edit";		
	}
	@PostMapping("/info_edit")
	public String info_edit(@ModelAttribute SellerDto sellerDto) {
//		sellerService.info_edit(sellerDto);
		return "redirect:/seller/info";		
	}
	
	//판매자 비밀번호 변경
	@GetMapping("/password")
	public String password() {
		return "seller/password";
		
	}
	@PostMapping("/password")
	public String password(@ModelAttribute SellerDto sellerDto) {
		return"redirect:/seller/password_success";
	}
	//판매자 비밀번호 변경 성공 페이지
	@GetMapping("/password_success")
	public String password_success() {
		return "seller/password_success";
	}
	@PostMapping("/password_success")
	 public String password_success(@ModelAttribute SellerDto sellerDto) {
		return "redirect:/";
	}
}
