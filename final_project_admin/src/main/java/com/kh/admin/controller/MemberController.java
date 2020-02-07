package com.kh.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.admin.entity.MemberDto;
import com.kh.admin.repository.MemberDao;
import com.kh.admin.service.BoardService;
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
	
	@GetMapping("/manage")
	public String manage(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		
		PagingVO vo = boardService.memberPagination(pno1);
		model.addAttribute("paging", vo);
		List<MemberDto> list = memberDao.memberGetList(vo);
		model.addAttribute("list", list);
		return "member/manage";
	}
}
