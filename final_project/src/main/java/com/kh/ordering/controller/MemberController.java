 package com.kh.ordering.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.entity.Member_PointDto;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.Member_PointDao;
import com.sun.mail.util.LogOutputStream;

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
	private SqlSession sqlSession;
	

	
	@GetMapping("/regist")
	public String regist() {
		return "member/regist";
	}
	
//	@PostMapping("/regist")
//	public String regist(
//			@ModelAttribute MemberDto 
//			memberDto,Member_PointDto member_PointDto
//			) {
		
		@PostMapping("/regist")
		public String regist(@ModelAttribute MemberDto member) {	
		 
			//멤버의 시퀀스 번호를 저장한다
			int seq = memberDao.MemberSeq(); 
			
			//멤버 시퀀스를  저장한다
			member.setMember_no(seq);
			
			System.out.println(member);
		
			//멤버 시퀀스를 회원에게 입력받은 6개의 데이터에 넣고 입력
			sqlSession.insert("member.regist",member);
			
			Member_PointDto member_PointDto = Member_PointDto.builder().member_no(seq).build();
			
			sqlSession.insert("member_PointDto.pointregist", member_PointDto);
			
			return "member/login"; //완료후 다른페이지로 이동시 리다이렉트로 보낸다
		}
	
		//레지스트 입력 후 포인트 등록에 불러온 시퀀스 번호를 넣고 입력한다
			
//			sqlSession.insert("member_PointDto.registsuccess",member_no);
//			log.info("member_no={}",member_no);
//			log.info("member_point_no={}",member_point_no);
			//등록
//		memberDao.regist(memberDto);
		
		
	
	
		
	
//	@PostMapping("/regist")
//	public String registPoint(
//			@ModelAttribute Member_PointDto member_PointDto) {
//		//등록
//		memberRegistDao.regist(member_PointDto);
//		
//		return "redirect:index"; //완료후 다른페이지로 이동시 리다이렉트로 보낸다
//	}
	
	@GetMapping("/registsuccess")
	public String registsuccess() {
		return "member/registsuccess";//완료한뒤 인덱스페이지로 보낼것을 준비
	}
	
	@PostMapping("/registsuccess")
	public String registsuccess(
			@ModelAttribute Member_PointDto member_pointDto) {
	
	member_PointDao.registsuccess(member_pointDto);
		
		
		return "redirect:home"; //완료후 다른페이지로 이동시 리다이렉트로 보낸다
	}	
	
	@GetMapping("/index")
	public String index() {
		return "member/index";
	}
	
	@GetMapping("/login")
	public String login() {
		return "member/login"; 
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto member) {
		MemberDto find = memberDao.login(member);
		if(find != null) {
			log.info("로그인 성공");
			//세션에 회원 정보 추가
			//필요하다면 쿠키도 생성
			
			return "redirect:/home";
		}
		else {
			log.info("로그인 실패");
			return "member/login";
		}
	}
	

	
	
//	@PostMapping("login")
//	public String login(@ModelAttribute MemberDto memberDto) {
//		MemberDto find = memberDao.login(memberDto);
//		
//		if(find != null) {
//			log.info("로그인 성공");
//			//세션에 회원정보 추가
//			//필요하다면 쿠키도 생성
//			return "redirect:/";
//		}
//		else {// 아이디가 없을경우
//			log.info("로그인 실패");
//			return "redirect:login";
//			
//		}
//		
//	}
	
}
