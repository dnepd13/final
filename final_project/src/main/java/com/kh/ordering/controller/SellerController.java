package com.kh.ordering.controller;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.text.*;

import org.apache.commons.io.filefilter.FalseFileFilter;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.SellerCategoryDao;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.EmailService;
import com.kh.ordering.service.RandomService;
import com.kh.ordering.service.SellerService;

import lombok.extern.slf4j.Slf4j;

//import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/seller")

public class SellerController {
	@Autowired
	private PasswordEncoder passwordEncoder;//password는bcrypt의 상위개념
	@Autowired
	private SellerService sellerService;
	@Autowired
	private EmailService emailService;

	@Autowired
	private RandomService randomService;
	@Autowired
	private SellerDao sellerDao;
	@Autowired
	private SellerDto sellerDto;
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private SellerCategoryDao sellerCategoryDao;
	//판매자 메인 홈
	@GetMapping("/main")

	public String main1(Model model,HttpSession session) {
		String seller_id =(String)session.getAttribute("seller_id");
		log.info("seller_id={}", seller_id);
		SellerDto sellerDto=SellerDto.builder().seller_id(seller_id).
				build();
		log.info("sellerDto={}",sellerDto);
			sellerDto.setSeller_id(seller_id);
SellerDto info=sellerDao.info(sellerDto);

model.addAttribute("sellerDto",info);
		return "/seller/main";
	}
	@PostMapping("main")
	public String main(Model model,HttpSession session) {
		String seller_id =(String)session.getAttribute("seller_id");
		SellerDto sellerDto=SellerDto.builder().seller_id(seller_id).
				build();
SellerDto info=sellerDao.info(sellerDto);

model.addAttribute("sellerDto",info);
		
		return"redirect:/seller/main";
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
	@PostMapping("/regist")
	public String regist(@ModelAttribute SellerDto sellerDto) {
		//sellerDto에 들어잇는 pw를 암호화 한다(test5bcrypt)
		
//		 String origin= sellerDto.getSeller_pw();
//		 String result = encoder.encode(origin);
//		 sellerDto.setSeller_pw(result);
		
		sellerDto.setSeller_pw(passwordEncoder.encode(sellerDto.getSeller_pw()));
		sellerService.regist(sellerDto);
	//	return"redirect:/seller/regist_success";
		return"redirect:/seller/login";
	}
	//판매자 이메일 인증
	@PostMapping("/send")//jsp로 결과가 나가면 안된다
	@ResponseBody//내가 반환하는 내용이 곧 결과물
	public String send(@RequestParam String seller_email,HttpSession session) {
//		String cert ="1236";//세션에 저장된 판매자 이름과 판매자 아이디를 넣어서 서버에 있는 아이디랑 이메일이 같다면 인증번호를 보내라 
	    System.out.println("seller email"+seller_email);	 
		String cert = randomService.generateCertificationNumber(6);
	    	  session.setAttribute("cert", cert);
	    	  return emailService.sendCertMessege(seller_email, cert);
	    	  
	      }
	@PostMapping("/validate")//세션에 있는 cert랑 사용자가 입력한 번호랑 같아야한다
	@ResponseBody
	public String validate(HttpSession session, @RequestParam String cert) {
			String value =(String)session.getAttribute("cert");//서버에 저장된 번호를 내놔라 사용자가 입력한 값이 cert로 들어와야한다
			      session.removeAttribute("cert");//세션값을 지운다 한번쓰면 지워야한다(버려야한다)
			      	//	System.out.println(cert+"11111111111");
			      
			      if (value.equals(cert)) {  //사용자가 입력한 값이 cert랑 같으면
			
				return "success";
			}	
				else {
					return "fail";
					
				}
	}
	
	//판매자 비밀번호 찾기
	@GetMapping("/pwfind")
	public String pwfind(HttpSession session, Model model) {

		return "seller/pwfind"; 
	}
	
	@PostMapping("pwfind")
	public String pwfind(@ModelAttribute SellerDto sellerDto, HttpSession session)
	{
		SellerDto login = sellerDao.emaillogin(sellerDto);
	session.setAttribute("seller_id", login.getSeller_id());
	return "redirect:/seller/emailpwchange";
	}
	
	//이메일 비밀번호 변경 완료
	@GetMapping("/emailpwchange")
	public String emailpwchange() {

		
		return "seller/emailpwchange";
		
	}	
	@PostMapping("/emailpwchange")
	public String emailpwchange(@ModelAttribute SellerDto sellerDto,HttpSession session) {
		String seller_id = (String)session.getAttribute("seller_id"); 
	//	log.info("seller_id={}", seller_id);
		sellerDto.setSeller_id(seller_id);
		//log.info("sellerDto={}",sellerDto);
		sellerDto.setSeller_pw(passwordEncoder.encode(sellerDto.getSeller_pw()));
		
			sellerDto.setSeller_id(seller_id); 
		
			sellerDao.change_pw(sellerDto);
		
			session.removeAttribute("seller_id");
			log.info("session ={}", session);
			
		return"redirect:/seller/login";
		}
	

			///아이디 중복검사
			@GetMapping(value = "/id_check",produces ="application/text; charset=utf-8")
			@ResponseBody //ajax로 보낼때 사용하는 어노테이션
			public String id_check(String seller_id, Model model) {
		 System.out.println("Controller.idCheck() 호출");
		 
		 int result = sqlSession.selectOne("seller.id_check", seller_id);
		log.info("들어오나");
		log.info("1={}",seller_id);
		log.info("result={}", result);
		String a = Integer.toString(result);
		if(result == 1) {
			return a;
		}
		else {
			return a;
		}
	   } 

/////////////가입완료후 페이지////////////////
	@GetMapping("/regist_success")
	public String regist_success() {
		return "redirect:/seller/regist_success";
	}
	

//	@PostMapping("/regist_success")
//	private String regist_success(@ModelAttribute SellerDto sellerDto) {
//		return "redirect:seller/regist_success";
//	}
	
///////////////////////////판매자 로그인///////////////////////////////////////
	@GetMapping("login")

	private String login( ) {
		return "seller/login";
		
	}
	@PostMapping("login")
	private String login(@ModelAttribute SellerDto sellerDto, 
									HttpSession session) {
		//비밀번호 암호화
		//아이디 검색을 하고 결과 유무 확인
			SellerDto find = sellerService.login(sellerDto);
			System.out.println(sellerDto);
			log.info("id={}",find);
			log.info("sellerDto={}",sellerDto);
		if(find == null) {
			log.info("asd={}",find);
				return "redirect:/seller/login?error";
		}
		else {//id가  잇으면--->비밀번호 매칭검사
			boolean correct =passwordEncoder.matches(sellerDto.getSeller_pw(),find.getSeller_pw());
//			boolean correct = sellerDto.getSeller_pw().equals(find.getSeller_pw());
			log.info("current={}",correct);
					if(correct == true) {   //비밀번호일치
						session.setAttribute("seller_id", find.getSeller_id());
						log.info("session={}"+session);
						return "redirect:/seller/main";				
					}
					else {
	//				log.info("asda");
						return "redirect:/seller/login?error";
					}		
		}
	}
	
	
////////////////////////////판매자 로그아웃///////////////////////////////////
	@GetMapping("/logout")

		public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";		
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
		log.info("sellerDtoedit={}",sellerDto);
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
		SellerDto find = sellerDao.login(sellerDto);
		boolean correct = passwordEncoder.matches(sellerDto.getSeller_pw(), find.getSeller_pw());
		if(correct==true) {
		return"redirect:/seller/change_pw";
	}
		else {
			return"redirect:/seller/check_pw";
		}
	}

	
	//판매자 비밀번호 변경
	@GetMapping("/change_pw")
	public String change_pw () {

		
		return "seller/change_pw";
		
	}	
	@PostMapping("/change_pw")
	public String change_pw(@ModelAttribute SellerDto sellerDto,HttpSession session) {
		String seller_id = (String)session.getAttribute("seller_id"); 

		sellerDto.setSeller_id(seller_id);

		sellerDto.setSeller_pw(passwordEncoder.encode(sellerDto.getSeller_pw()));

		sellerDto.setSeller_id(seller_id); 
		sellerDao.change_pw(sellerDto);
		
		session.removeAttribute("seller_id");
			
			return"redirect:/";	
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
	public String delete(HttpSession session, @ModelAttribute SellerDto sellerDto) {
		try {
			String seller_id = (String)session.getAttribute("seller_id");
			sellerDto.setSeller_id(seller_id);
			
			SellerDto login = sellerDao.login(sellerDto);
		
			boolean correct = passwordEncoder.matches(sellerDto.getSeller_pw(),login.getSeller_pw());
			
			if(correct) {
				
				sellerDao.delete(login);
				session.removeAttribute("seller_id");
				
				return "redirect:/seller/deleteSuccess";
			}
			else {
				return "redirect:/seller/deleteFail";
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "redirect:/?error";
		}
	}
	
	//탈퇴성공
	@GetMapping("deleteSuccess")
	public String deleteSuccess() {
		
		return "member/deleteSuccess";
	}
	//탈퇴 비밀번호 실패 
	@GetMapping("deleteFail")
	public String deleteFail() {
		
		return "member/deleteFail";
	}
	
	//탈퇴실패
	@GetMapping("/registsuccess")
	public String registsuccess() {
		return "member/registsuccess";//완료한뒤 인덱스페이지로 보낼것을 준비
	}
	
	
	@PostMapping("/delete_proc")
		public String delete_proc( HttpSession session,@ModelAttribute SellerDto sellerDto) {
			String seller_id = (String)session.getAttribute("seller_id");
			String input_pw = sellerDto.getSeller_pw();
			String a = passwordEncoder.encode(input_pw);
			sellerDto.setSeller_id(seller_id);
			SellerDto login = sellerDao.login(sellerDto);
	//		log.info("seller_login={}", login);
//			SellerDto find=SellerDto.builder().seller_id(seller_id).build();
																	//유저에서가져온 값, db에서 가져온 값
			//matche(인풋박스에서 유저가 입력한 텍스트 그대로 , 뒤는 맞);
			//boolean correct = passwordEncoder.matches("rrrr", login.getSeller_pw());
//		
//			if(login == null) {
//				return "redirect:/";
//				 }					
//			else {
//				session.invalidate();
//				sellerDao.delete(login);		
//				return "redirect:/seller/main";
//				
//			}
			//나중에 지워
			return "seller/delete";
	}
	///////////////////////////////////////////////////
	
	//-------------------아이디 찾기-------------------------//
	@GetMapping("/find_id")
	public String find_id() {
		return "seller/find_id";
				
	}
	@PostMapping("/find_id")

	public String find_id(HttpSession session,@RequestParam String seller_email,
			@RequestParam String seller_name,Model model) {
			log.info("1= {}", seller_email);
			log.info("2= {}", seller_name);
			SellerDto sellerDto =SellerDto.builder().seller_name(seller_name) //sellerDto에 이름과이메일을 넣는다
																	   .seller_email(seller_email)
																	   .build();
			log.info("2sellerDto={}",sellerDto);
			SellerDto find_id=sellerDao.find_id(sellerDto);
			log.info("2find_id={}",sellerDto);
			log.info("2find_id={}",find_id);
			model.addAttribute("sellerDto",find_id);
		return "/seller/find_id_info";
				
}
	@GetMapping("/find_id_info")
	
	public String find_id_info2(HttpSession session,@RequestParam(value = "seller_email",required = false ,defaultValue = "" ) String seller_email,
			@RequestParam (value = "seller_name",required = false ,defaultValue = "" ) String seller_name,
				Model model) {
	String name =(String)session.getAttribute("seller_name");
	String email =(String)session.getAttribute("seller_email");
		
			SellerDto sellerDto =SellerDto.builder().seller_name(seller_name) //sellerDto에 이름과이메일을 넣는다
																	   .seller_email(seller_email)
																	   .build();
			log.info("sellerDto={}",sellerDto);
			SellerDto find_id=sellerDao.find_id(sellerDto);
				log.info("find_id={}",find_id);
		//	model.addAttribute("sellerDto",find_id);
		
		return "seller/find_id_info";
				
	}
	@PostMapping("/find_id_info")

	public String find_id_info(HttpSession session,@RequestParam(value = "seller_email",required = false ,defaultValue = "" ) String seller_email,
			@RequestParam(value = "seller_name",required = false ,defaultValue = "" ) String seller_name,Model model) {
	String name =(String)session.getAttribute("seller_name");
		String email =(String)session.getAttribute("seller_email");
			SellerDto sellerDto =SellerDto.builder().seller_name(seller_name) //sellerDto에 이름과이메일을 넣는다
																	   .seller_email(seller_email)
																	   .build();
			log.info("sellerDto={}",sellerDto);
			SellerDto find_id=sellerDao.find_id(sellerDto);
			log.info("find_id={}",find_id);
//			model.addAttribute("sellerDto",find_id);
		return "redirect:/seller/login";
}
}