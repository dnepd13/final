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

import com.kh.admin.entity.AdminQnaBoardDto;
import com.kh.admin.repository.BoardDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private BoardDao boardDao;
	
	@GetMapping("/manageqna")
	public String manage(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		
		PagingVO vo = boardService.adminQnaPagination(pno1);
		List<AdminQnaBoardDto> list = boardDao.qnaBoardGetList(vo);
		
		model.addAttribute("paging", vo);
		model.addAttribute("list", list);
		return "board/manageqna";
	}
	
	//관리문의 게시판 글 하나 보기
	@GetMapping("/detailqna")
	public String detailqna(
			@ModelAttribute AdminQnaBoardDto adminQnaBoardDto,
			Model model
			) {
		AdminQnaBoardDto result = boardDao.qnaBoardGetOne(adminQnaBoardDto);
		model.addAttribute("one", result);
		
		return "board/detailqna";
	}
	
	//관리문의 게시판 글작성하기
	@GetMapping("write")
	public String write(
			@RequestParam(value = "admin_qna_no", required = false, defaultValue = "0") int admin_qna_no,
			Model model
			) {
		if(admin_qna_no > 0) {
			model.addAttribute(admin_qna_no);
		}
		return "board/write";
	}
	
	@PostMapping("write")
	public String write(
			@ModelAttribute AdminQnaBoardDto adminQnaBoardDto,
			@RequestParam(value = "admin_qna_no1", required = false, defaultValue = "0") int admin_qna_no1
			) {
		log.info("dlrjqhwk={}",adminQnaBoardDto);
		log.info("asd={}",admin_qna_no1);
		return "redirect:/board/manageqna";
	}
}
