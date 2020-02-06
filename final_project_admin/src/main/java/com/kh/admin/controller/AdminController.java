package com.kh.admin.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.repository.AdminDao;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	//---------------------------로그인창----------------------------------
	@GetMapping("/")
	public String login() {
		
		return "login";
	}
	//---------------------------로그인창----------------------------------
	@PostMapping("/")
	public String login(
			@ModelAttribute AdminDto adminDto,
			HttpSession session
			) {
			try {
			AdminDto login= adminDao.login(adminDto);
			if(login == null) {
				return "redirect:/?error";
			}
			else {
				boolean correct = passwordEncoder.matches(adminDto.getAdmin_pw(), login.getAdmin_pw());
				if(correct) {
					
					session.setAttribute("admin_id", login.getAdmin_id());
					session.setAttribute("admin_grade", login.getAdmin_grade());
					adminDao.lastLogin(adminDto);
					return "redirect:/home";
				}
				else {
					return "redirect:/?error";
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/?error";
		}
	
	}
	//---------------------------홈창----------------------------------
	@GetMapping("/home")
	public String home() {
		return "/home";
	}
	//---------------------------관리자가입창----------------------------------
	@GetMapping("/regist")
	public String regist() {
		return "/regist";
	}
	//---------------------------관리자가입창----------------------------------
	@PostMapping("/regist")
	public String regist(@ModelAttribute AdminDto adminDto) {
		adminDto.setAdmin_pw(passwordEncoder.encode(adminDto.getAdmin_pw()));
		adminDao.regist(adminDto);

		return "/regist";
	}
	//---------------------------수수료창----------------------------------
	@GetMapping("/premium")
	public String premium() {
		return "/premium";
	}
	
	//---------------------------로그아웃창----------------------------------
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("admin_id");
		session.removeAttribute("admin_grade");
		return "redirect:/";
	}
	
	//---------------------------카테고리 관리창----------------------------------
	@GetMapping("/category")
	public String category() {
		return "/category";
	}
}
