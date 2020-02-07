package com.kh.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.CategoryDto;
import com.kh.admin.repository.AdminDao;
import com.kh.admin.repository.CategoryDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CategoryDao categoryDao;
	
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
			log.info("1={}",login);
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
		
		log.info(adminDto.getAdmin_id());
		log.info(adminDto.getAdmin_grade());
		log.info(adminDto.getAdmin_email());
		log.info(adminDto.getAdmin_join_date());
		log.info(adminDto.getAdmin_last_login());
		log.info(adminDto.getAdmin_name());
		log.info(adminDto.getAdmin_pw());
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
	public String category(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		PagingVO vo = boardService.categoryPagination(pno1);
		model.addAttribute("paging",vo);
		
		List<CategoryDto> list= categoryDao.categoryGetList(vo);
		model.addAttribute("list", list);
		return "/category";
	
	}
	//---------------------------카테고리 등록----------------------------------
	@PostMapping("/category")
	public String categoryInsert(
			@ModelAttribute CategoryDto categoryDto
			) {
		categoryDao.insertCategory(categoryDto);
		return "redirect:/category";
	}
	//---------------------------카테고리 업데이트----------------------------------
	@PostMapping("/categoryUpdate")
	@ResponseBody
	public String categoryUpdate(
			@RequestParam int category_no,
			@RequestParam String category_large,
			@RequestParam String category_middle,
			@RequestParam String category_small
			) {
		
		log.info("1={}", category_no);
		log.info("1={}", category_large);
		log.info("1={}", category_middle);
		log.info("1={}", category_small);
		
		CategoryDto categoryDto = CategoryDto.builder()
																		.category_no(category_no)
																		.category_large(category_large)
																		.category_middle(category_middle)
																		.category_small(category_small)
																	.build();
		
		categoryDao.updateCategory(categoryDto);
		return "/category";
	}
	
	//---------------------------카테고리 삭제----------------------------------
	@PostMapping("/categoryDelete")
	@ResponseBody
	public String categoryDelete(
			@RequestParam int category_no
			) {
		categoryDao.deleteCategory(category_no);
		
		return "redirect:/category";
	}
	
}
