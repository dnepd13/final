 package com.kh.ordering.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.entity.Member_PointDto;
import com.kh.ordering.entity.Member_AddrDto;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.Member_AddrDao;
import com.kh.ordering.repository.Member_PointDao;
import com.kh.ordering.service.MemberService;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private Member_PointDao member_PointDao;
	
	@Autowired
	private Member_AddrDao member_AddrDao;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private SqlSession sqlSession;
	
	

	
	@GetMapping("/regist")
	public String regist() {
		return "member/regist";
	}
	
		
		@PostMapping("/regist")
		public String regist(@ModelAttribute MemberDto member) {	
			
			
			//멤버의 시퀀스 번호를 저장한다
			int seq = memberDao.MemberSeq(); 
			
			//멤버 시퀀스를  저장한다
			member.setMember_no(seq);
			
			System.out.println(member);
		
			//memberDto에 들어가 있는 pw를 암호화 한다(bcrypt)
			
//			//멤버의 pw를 가져오고
//			String origin= member.getMember_pw();
//			//가져온 pw를 암호화한다
//			String result = encoder.encode(origin);
//			//멤버에 pw를 넣는다
//			member.setMember_pw(result);
			member.setMember_pw(encoder.encode(member.getMember_pw()));
			
			
			//멤버 시퀀스를 회원에게 입력받은 6개의 데이터에 넣고 입력
			sqlSession.insert("member.regist",member);
			
			Member_PointDto member_PointDto = Member_PointDto.builder().member_no(seq).build();
			
			sqlSession.insert("member_PointDto.pointregist", member_PointDto);
			
			return "member/login"; //완료후 다른페이지로 이동시 리다이렉트로 보낸다
		}
	

	
//	@GetMapping("/registsuccess")
//	public String registsuccess() {
//		return "member/registsuccess";//완료한뒤 인덱스페이지로 보낼것을 준비
//	}
//	
//	@PostMapping("/registsuccess")
//	public String registsuccess(
//			@ModelAttribute Member_PointDto member_pointDto) {
//	
//	member_PointDao.registsuccess(member_pointDto);
//		
//		
//		return "redirect:home"; //완료후 다른페이지로 이동시 리다이렉트로 보낸다
//	}	
	
	
	@GetMapping("/login")
	public String login() {
		return "member/login"; 
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto member, HttpSession session) {
		MemberDto find = memberDao.login(member);
		log.info("member={}", member);
		
		
		if(find == null) {//아이디가 없으면
			return "redirect:/login";
		}
		
		
		else {//아이디가 있으면 비밀번호 매칭 검사
		
			
			boolean correct = encoder.matches(member.getMember_pw(), find.getMember_pw());
			log.info("correct={}",correct);
			if(correct = true) {//비밀번호 일치
				
			
			log.info("로그인 성공");
			//세션에 회원 정보 추가 member_id
			session.setAttribute("member_id", find.getMember_id());
			
			// 최종로그인
			memberDao.lastLogin(member);
			log.info("1={}", find);
			//필요하다면 쿠키도 생성
			
			return "redirect:/home";
		}
			else {//로그인이 실패 했을 경우 확인을 위한 구문
			
			
			log.info("로그인 실패");
			return "member/login";
		}
			
	}
}
	

	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("member_id");
		
		return "/home";
	}
	
	
	
	
	@GetMapping("/shipaddr")
	public String shipaddress () {
	
	
		return "member/shipaddr";
	}
	
	
	
	@GetMapping("/insertaddr")
	public String registaddr() {
		
		return "member/insertaddr";
	}
	
	@PostMapping("/insertaddr")
	public String registaddr(@ModelAttribute Member_AddrDto member_AddrDto) {

		// session값에 있는 아이디를 찾아서 번호를 구해왔고 
//		String member_id =(String)session.getAttribute("member");
//		int member_no = memberDao.findno("member_id");
//		
//		log.info("member={}",member_no);		
		
//		member_AddrDto = Member_AddrDto.builder().member_no(member_no).build();
		
		//멤버 시퀀스를 회원에게 입력받은 4개의 데이터에 넣고 입력
		//sqlSession.insert("member_AddrDto.insertaddr",member_AddrDto);
//		member_addrDto에 번호를 152번으로 설정한 뒤  DAO를 이용하여 insert
		

		
		return "redirect:/member/insertaddr";
		
		
		
	
	}	
	
}