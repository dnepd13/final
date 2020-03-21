package com.kh.admin.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.admin.entity.MemberDto;
import com.kh.admin.repository.MemberDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.service.EmailService;
import com.kh.admin.vo.BlockMemberVO;
import com.kh.admin.vo.BlockSellerVO;
import com.kh.admin.vo.MemberPointVO;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;



@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private EmailService emailService;
	
	//회원 목록 뽑기
	@GetMapping("/manage")
	public String manage(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute PagingVO paging
			) {
		
		int count;
		if(paging.getKey()==null) {
			count = memberDao.memberCount();
			PagingVO vo = boardService.allPaging(pno1, count);
			model.addAttribute("paging", vo);
			vo.setKey(paging.getKey());
			vo.setSearch(paging.getSearch());
			
			List<BlockMemberVO> list = memberDao.memberGetList(vo);
			model.addAttribute("list", list);
			//현재 년도, 월, 일
			
			Date date1 = new Date();
			log.info("date={}",date1);
			
			SimpleDateFormat date2 = new SimpleDateFormat("yyyy-MM-dd");
			log.info("date2={}",date2.format(date1));
			model.addAttribute("today", date2.format(date1));
			return "member/manage";

		}
		else if(paging.getKey().equalsIgnoreCase("member_id")) {
			String member_id = paging.getSearch();
			count = memberDao.memberIdCount(member_id);
			
			PagingVO vo = boardService.allPaging(pno1, count);
			model.addAttribute("paging", vo);
			vo.setKey(paging.getKey());
			vo.setSearch(paging.getSearch());
			
			List<BlockMemberVO> list = memberDao.memberGetList(vo);
			model.addAttribute("list", list);
			return "member/manage";
		}
		//이름
		else if(paging.getKey().equalsIgnoreCase("member_name")) {
			String member_name = paging.getSearch();
			count = memberDao.memberNameCount(member_name);
			
			PagingVO vo = boardService.allPaging(pno1, count);
			model.addAttribute("paging", vo);
			vo.setKey(paging.getKey());
			vo.setSearch(paging.getSearch());
			
			List<BlockMemberVO> list = memberDao.memberGetList(vo);
			model.addAttribute("list", list);
			return "member/manage";
		}
		//등급
		else if(paging.getKey().equalsIgnoreCase("member_grade")) {
			String member_grade = paging.getSearch();
			count = memberDao.memberGradeCount(member_grade);
			
			PagingVO vo = boardService.allPaging(pno1, count);
			model.addAttribute("paging", vo);
			vo.setKey(paging.getKey());
			vo.setSearch(paging.getSearch());
			
			List<BlockMemberVO> list = memberDao.memberGetList(vo);
			model.addAttribute("list", list);
			return "member/manage";
		}
		//생년월일로 구하기
		else {
			
			return "member/manage";
		}
	}
	
	//멤버 상세보기
	@PostMapping("/memberpage")
	public String memberpage(
			@ModelAttribute MemberDto memberDto,
			Model model
			) {
			
		model.addAttribute("one", memberDao.memberGetOne(memberDto));
		
		return "member/memberpage";
	}
	
	//회원 삭제
	@GetMapping("/delete")
	public String memberDelete(
			@ModelAttribute MemberDto memberDto
			) {
			
		memberDao.memberDelete(memberDto);
		
		return "redirect:/member/manage";
	}
	
	//회원 별 포인트 조회
	@GetMapping("/point")
	public String memberPoint(
			@RequestParam String member_id,
			@RequestParam(value="pno1", required = false) String pno1,
			@RequestParam int member_no,
			Model model
			) {
			
		model.addAttribute("member_id",member_id);
		MemberPointVO memberPointVO = MemberPointVO.builder().member_no(member_no).build();
		int result = memberDao.pointSumGet(memberPointVO);
		model.addAttribute("pointsum", result);
		PagingVO paging = boardService.pointPagination(pno1, member_no);
		paging.setMember_no(member_no);
		model.addAttribute("paging", paging);
		
		List<MemberPointVO> list = memberDao.pointGetOneMemberList(paging);
		model.addAttribute("list", list);
		return "member/point";
	}
	
	//회원 포인트 삭제
	@PostMapping("/point")
	public String point(
			@RequestParam int member_point_no,
    		@RequestParam int paging_member_no
			) {
			
		MemberDto memberDto = MemberDto.builder().member_no(paging_member_no).build();
		MemberDto result = memberDao.memberGetOne(memberDto);
		memberDao.poingDelete(member_point_no);
		return "redirect:point?member_id="+result.getMember_id()+"&member_no="+paging_member_no;
	}
	
	//포인트 등록
	@GetMapping("/pointregist")
	public String pointregist(
			@RequestParam int member_no,
			Model model
			) {
		
		MemberDto memberDto = MemberDto.builder().member_no(member_no).build();
		MemberDto result = memberDao.memberGetOne(memberDto);
		model.addAttribute("member", result);
		
		return "member/pointregist";
	}
	
	@PostMapping("/pointregist")
	public String pointregist(
			@ModelAttribute MemberPointVO memberPointVO,
			HttpServletRequest req
			) {
			
		String admin = (String) req.getSession().getAttribute("admin_id");
		memberPointVO.setMember_point_admin(admin);
		memberDao.pointRegist(memberPointVO);
		MemberDto memberDto = MemberDto.builder()
																.member_no(memberPointVO.getMember_no())
																.build();
		MemberDto result = memberDao.memberGetOne(memberDto);
		
		
		return "redirect:point?member_id="+result.getMember_id()+"&member_no="+result.getMember_no();
	}
	
	
	//---------------------선택해서 포인트 주기 ------------------------------
	@GetMapping(value="/providepoint", produces = "application/text; charset=utf-8")
	public String providepoint() {
					
				return "member/providepoint";
	}
	
	@PostMapping(value = "/pointAllRegist", produces = "application/text; charset=utf-8")
	@ResponseBody
	public String pointAllRegist(
			@RequestParam(value = "valueArrTest[]") List<String> valueArr,
			@RequestParam int point,
			@RequestParam String reason,
			@RequestParam String lastdate,
			HttpServletRequest req
			) {
		
		String admin = (String) req.getSession().getAttribute("admin_id");
		log.info("vlaie={}", valueArr.get(0));
		log.info("point={}", point);
		log.info("reason={}", reason);
		log.info("lastdate={}", lastdate);
		List<MemberPointVO> list = new ArrayList<>();
		for(int i = 0; i < valueArr.size(); i++) {
			MemberPointVO memberPointVO = new MemberPointVO();
			memberPointVO.setMember_no(Integer.parseInt(valueArr.get(i)));
			memberPointVO.setMember_point_change(point);
			memberPointVO.setMember_point_limit(lastdate);
			memberPointVO.setMember_point_content(reason);
			memberPointVO.setMember_point_admin(admin);
			list.add(memberPointVO);
		}
		log.info("list={}",list);
		memberDao.memberPointMulti(list);
		String a = "포인트 적립을 완료했습니다";
		return a;
	}
	
	@PostMapping("/reset")
	public String reset(
			@RequestParam int member_no,
			@RequestParam String member_pw,
			@RequestParam String member_email,
			Model model
			) {
		
		MemberDto memberDto = MemberDto.builder()
										.member_no(member_no)
										.member_pw(passwordEncoder.encode(member_pw))
										.build();
		memberDao.memberChangePw(memberDto);
		
		try {
			emailService.sendMessage(member_email);
			model.addAttribute("email", member_email);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/member/manage";
	}
}
