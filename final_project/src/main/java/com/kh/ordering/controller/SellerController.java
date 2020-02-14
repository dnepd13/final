package com.kh.ordering.controller;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.text.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.SellerService;

import lombok.extern.slf4j.Slf4j;

//import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/seller")

public class SellerController {
	@Autowired
	private SellerService sellerService;
	
	@Autowired
	private SellerDao sellerDao;
	@Autowired
	private SellerDto sellerDto;
	@Autowired
	private SqlSession sqlSession;
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
	///아이디 중복검사
	@ResponseBody //ajax로 보낼때 사용하는 어노테이션
			@GetMapping("/id_check")
			public String id_check(String seller_id, Model model) {
		 System.out.println("Controller.idCheck() 호출");
		SellerDto sellerDto = sqlSession.selectOne("seller.id_check", seller_id);
		log.info("들어오나");
		log.info("1={}",seller_id);
		//알림 한글은 ??????이렇게 뜸~ 수정 필요
					      if (sellerDto != null) {
					         return "usedname";
					      } else {
					         return "사용가능한 아이디 입니다.";
					      }
					   } 

/////////////가입완료후 페이지////////////////
	@GetMapping("/regist_success")
	public String regist_success() {
		return "seller/regist_success";
	}
	

	@PostMapping("/regist_success")
	private String regist_success(@ModelAttribute SellerDto sellerDto) {
		return "redirect:seller/regist_success";
	}
	
///////////////////////////판매자 로그인///////////////////////////////////////
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
	/////////////////////아이디 찾기////////////////////////////////////////
	@GetMapping("/find_id")
	public String find_id() {
		return "seller/find_id";
	}
	@PostMapping("/find_id")
	 public String find_id(@ModelAttribute SellerDto sellerDto,HttpSession session) {
		String seller_name=(String)session.getAttribute("seller_name");
		String seller_email=(String)session.getAttribute("seller_email");
		sellerDto.setSeller_name(seller_name);
		sellerDto.setSeller_email(seller_email);
		SellerDto result = sellerDao.info(sellerDto);
		
	//	sellerDto.getSeller_name(),info.getSeller_name();
		
		
		
	
		
		return "redirect:/seller/find_id_success";
	}
	@PostMapping("/find_id_success")
	public String find_id(Model model, HttpSession session ) {
		String seller_name=(String)session.getAttribute("seller_name");
		String seller_email=(String)session.getAttribute("seller_email");
		 
	//	SellerDto info=sellerDao.info(sellerDto);
		//model.addAttribute("sellerDto",info);
		return "seller/find_id_success";
	}
	
////////////////////////////판매자 로그아웃///////////////////////////////////
	@GetMapping("/logout")
		public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/seller/login";		
	}
	///////////////////////// 판매자 관리 페이지////////////////////////////////////////////////////////////
	@GetMapping("/management")
	 public String management(@ModelAttribute SellerDto sellerDto) {
		return"seller/management";
	}

//////////////////////////판매자 정보 조회///////////////////////////////////////////////////////
	@GetMapping("/info")
	public String info1(Model model,HttpSession session) {
		String seller_id=(String)session.getAttribute("seller_id");
//		SellerDto sellerDto = sellerDao.i
		SellerDto sellerDto=SellerDto.builder().seller_id(seller_id).
													build();
	//	log.info("dto={}",sellerDto);
		SellerDto info=sellerDao.info(sellerDto);
		
	//	log.info("seller={}", info);
		model.addAttribute("sellerDto",info);
		return "seller/info";
		
	}
	@PostMapping("/info")
	public String info(Model model,HttpSession session) {
		String seller_id=(String)session.getAttribute("seller_id");
		SellerDto sellerDto=SellerDto.builder().seller_id(seller_id).
				build();
	//		log.info("dto={}",sellerDto);
				SellerDto info=sellerDao.info(sellerDto);

		//			log.info("seller={}", info);
						model.addAttribute("sellerDto",info);
		return"redirect:/seller/info_edit";
	}
///////////판매자 정보 수정하기/////////////////////
	@GetMapping("/info_edit")
	public String info_edit(Model model,HttpSession session) {
		String seller_id=(String)session.getAttribute("seller_id");
		SellerDto sellerDto=SellerDto.builder().seller_id(seller_id).
													build();
		SellerDto info=sellerDao.info(sellerDto);
		model.addAttribute("sellerDto",info);
		return "seller/info_edit";		
	}
	@PostMapping("/info_edit")
	public String info_edit(@ModelAttribute SellerDto sellerDto,HttpSession session) {
		String seller_id=(String)session.getAttribute("seller_id");
		sellerDto.setSeller_id(seller_id);
		SellerDto info_edit=sellerDao.info_edit(sellerDto);
		
		//SellerDto info_edit=sellerDao.info_edit(sellerDto);
//		session.setAttribute("seller_id", sellerDto.getSeller_id());
//		sellerDao.info(sellerDto);
		
		return "redirect:/seller/info";		
	}
	//	비밀번호 확인 페이지
	@GetMapping("/check_pw")
	public String check_pw() {
		return "seller/check_pw";
	}
	@PostMapping("/check_pw")
	public String check_pw(@ModelAttribute SellerDto sellerDto,HttpSession session) {
		String seller_id = (String)session.getAttribute("seller_id");
		sellerDto.setSeller_id(seller_id);
		SellerDto login = sellerDao.login(sellerDto);
		boolean correct = encoder.matches(sellerDto.getSeller_pw(), login.getSeller_pw());
		return"redirect:/seller/change_pw";
	}
	
	//판매자 비밀번호 변경
	@GetMapping("/change_pw")
	public String change_pw() {
		return "seller/change_pw";
		
	}
	@PostMapping("/change_pw")
	public String change_pw(@ModelAttribute SellerDto sellerDto,HttpSession session) {
		String seller_id = (String)session.getAttribute("seller_id"); 
	//	log.info("seller_id={}", seller_id);
		sellerDto.setSeller_id(seller_id);
		//log.info("sellerDto={}",sellerDto);
//		SellerDto login =sellerDao.login(sellerDto);
	//	log.info("seller_login={}", login);
		sellerDto.setSeller_pw(encoder.encode(sellerDto.getSeller_pw()));
		//SellerDto change_pw=SellerDto.builder().seller_id(seller_id).build();
		sellerDto.setSeller_id(seller_id); 
			sellerDao.changepw(sellerDto);
			return"redirect:/seller/change_pw_success";
		
//		session.setAttribute("seller_id",sellerDto.getSeller_id());
//		boolean correct = encoder.matches(sellerDto.getSeller_pw(), change_pw.getSeller_pw());
//		if(correct==true) {
//					}
//		else {
//			return"redirect:/seller/change_pw";
//		}
//		
	}
	//판매자 비밀번호 변경 성공 페이지
	@GetMapping("/change_pw_success")
	public String change_pw_success() {
		return "seller/change_pw_success";
	}
/////////판매자  회원탈퇴///////////////////
	@GetMapping("/delete")
		public String delete() {

			return "seller/delete";
			}
	@PostMapping("/delete")
		public String delete( HttpSession session,@ModelAttribute SellerDto sellerDto
	/* ,@RequestParam String seller_pw1 */) {
	//		log.info("seller_wwww={}", sellerDto);
			//log.info("seller_pw1={}",seller_pw);
			String seller_id = (String)session.getAttribute("seller_id");
			sellerDto.setSeller_id(seller_id);
			SellerDto login = sellerDao.login(sellerDto);
	//		log.info("seller_login={}", login);
//			SellerDto find=SellerDto.builder().seller_id(seller_id).build();
																	//유저에서가져온 값, db에서 가져온 값
			boolean correct = encoder.matches(sellerDto.getSeller_pw(), login.getSeller_pw());
			if(login == null) {
				return "redirect:/seller/management";
				 }					
			else {
				session.invalidate();
				sellerDao.delete(login);		
				return "redirect:/seller/main";
				
					}
		}
	///////////////////////////////////////////////////
}
