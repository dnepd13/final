package com.kh.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.admin.entity.MemberDto;
import com.kh.admin.repository.MemberDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.vo.BlockMemberVO;
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
	
	//회원 목록 뽑기
	@GetMapping("/manage")
	public String manage(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		
		PagingVO vo = boardService.memberPagination(pno1);
		model.addAttribute("paging", vo);
		List<BlockMemberVO> list = memberDao.memberGetList(vo);
		log.info("list={}", list);
		model.addAttribute("list", list);
		return "member/manage";
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
			@ModelAttribute MemberPointVO memberPointVO
			) {
		memberDao.pointRegist(memberPointVO);
		MemberDto memberDto = MemberDto.builder()
																.member_no(memberPointVO.getMember_no())
																.build();
		MemberDto result = memberDao.memberGetOne(memberDto);
		
		
		return "redirect:point?member_id="+result.getMember_id()+"&member_no="+result.getMember_no();
	}
	
}
