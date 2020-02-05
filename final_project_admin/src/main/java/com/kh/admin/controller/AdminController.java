package com.kh.admin.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.repository.LoginDao;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {
	@Autowired
	private LoginDao loginDao;
	
	@GetMapping("/")
	public String login() {
		
		return "login";
	}
	
	@PostMapping("/")
	public String login(
			AdminDto adminDto,
			HttpSession session
			) {
			try {
			AdminDto login= loginDao.login(adminDto);
			session.setAttribute("admin_id", login.getAdmin_id());
			session.setAttribute("admin_grade", login.getAdmin_grade());
			log.info(login.getAdmin_id());
			return "redirect:/home";
		
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/?error";
		}
	
	}
	
	@GetMapping("/home")
	public String home() {
		return "/home";
	}
	
	@GetMapping("/regist")
	public String regist() {
		return "/regist";
	}
}
