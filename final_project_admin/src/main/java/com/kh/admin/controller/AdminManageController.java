package com.kh.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
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

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminManageController {
	@Autowired
	private AdminManageDao adminManage;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@GetMapping("/manage")
	public String manage(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		try {
			
		
		PagingVO vo = boardService.pagination(pno1);
		
		model.addAttribute("paging", vo);
		List<AdminDto> list = adminManage.selectBoard(vo);
		model.addAttribute("list", list);
		return "admin/manage";
		} catch (Exception e) {
			e.printStackTrace();
			return "admin/manage";
		}
	}
	
	@PostMapping("/manage")
	public String manage(
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute AdminDto adminDto) {
		try {
		adminManage.adminDelete(adminDto);
		
		return "redirect:/admin/manage?pno1="+pno1;
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/admin/manage?pno1="+pno1;
		}
	}
	
	@GetMapping("/my")
	public String my(
			HttpSession session,
			Model model
			) {
		String id = (String)session.getAttribute("admin_id");
		model.addAttribute("my", adminManage.adminMy(id));
		return "admin/my";
	}
	
	@GetMapping("/changepw")
	public String changepw(
			) {
		return "admin/changepw";
	}
	
	@PostMapping("/changepw")
	public String changepw(
			@RequestParam String admin_pw,
			@RequestParam String new_admin_pw,
			@RequestParam int admin_no
			) {
		
		AdminDto adminDto =  adminManage.adminCheckPw(admin_no);
		
		boolean correct = passwordEncoder.matches(admin_pw, adminDto.getAdmin_pw());
		
		if(!correct) {
			
			return "redirect:/admin/changepw?error=error";
		}
		else {
			AdminDto newAdminPw = new AdminDto();
			newAdminPw.setAdmin_pw(passwordEncoder.encode(new_admin_pw));
			newAdminPw.setAdmin_no(admin_no);
			
			adminManage.adminChangePw(newAdminPw);
			return "redirect:/admin/my";
		}
	}
	
	@PostMapping("/reset")
	public String reset(
			@RequestParam int admin_no,
			@RequestParam String admin_pw
			) {
		
		AdminDto adminDto = AdminDto.builder()
													.admin_no(admin_no)
													.admin_pw(passwordEncoder.encode(admin_pw))
													.build();
					
		adminManage.adminChangePw(adminDto);
		
		return "redirect:/admin/manage";
	}
	
}
