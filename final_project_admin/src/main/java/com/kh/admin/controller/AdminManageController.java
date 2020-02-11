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

import com.kh.admin.entity.AdminDto;
import com.kh.admin.repository.AdminManageDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.vo.PagingVO;

@Controller
@RequestMapping("/admin")
public class AdminManageController {
	@Autowired
	private AdminManageDao adminManage;
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/manage")
	public String manage(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		PagingVO vo = boardService.pagination(pno1);
		
		model.addAttribute("paging", vo);
		List<AdminDto> list = adminManage.selectBoard(vo);
		model.addAttribute("list", list);
		return "admin/manage";
	}
	
	@PostMapping("/manage")
	public String manage(
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute AdminDto adminDto) {
		adminManage.adminDelete(adminDto);
		
		return "redirect:/admin/manage?pno1="+pno1;
	}
}
