package com.kh.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.AdminQnaBoardDto;
import com.kh.admin.repository.AdminDao;
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
	
	@Autowired
	private AdminDao adminDao;
	
	@GetMapping("/manageqna")
	public String manage(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute PagingVO paging
			) {
		try {
			
		
		int count;
		if(paging.getKey() == null) {
			
			count = boardDao.adminQnaCount();
			PagingVO vo = boardService.allPaging(pno1, count);
			List<AdminQnaBoardDto> list = boardDao.qnaBoardGetList(vo);
			
			model.addAttribute("paging", vo);
			model.addAttribute("list", list);
			
			return "board/manageqna";
		}
		else if(paging.getKey().equalsIgnoreCase("admin_qna_title")) {
			String admin_qna_title = paging.getSearch();
			count = boardDao.qnaBoardTitleCount(admin_qna_title);
			PagingVO vo = boardService.allPaging(pno1, count);
			
			model.addAttribute("paging", vo);
			vo.setKey(paging.getKey());
			vo.setSearch(paging.getSearch());
			
			List<AdminQnaBoardDto> list = boardDao.qnaBoardGetList(vo);
			model.addAttribute("list", list);
			return "board/manageqna";
		}
		else if(paging.getKey().equalsIgnoreCase("admin_qna_head")) {
			String admin_qna_head = paging.getSearch();
			count = boardDao.qnaBoardHeadCount(admin_qna_head);
			PagingVO vo = boardService.allPaging(pno1, count);
			
			model.addAttribute("paging", vo);
			vo.setKey(paging.getKey());
			vo.setSearch(paging.getSearch());
			
			List<AdminQnaBoardDto> list = boardDao.qnaBoardGetList(vo);
			model.addAttribute("list", list);
			return "board/manageqna";
		}
		else {
			
			return "board/manageqna";
		}
		} catch (Exception e) {
			e.printStackTrace();
			return "board/manageqna";
		}
	}
	
	//관리문의 게시판 글 하나 보기
	@GetMapping("/detailqna")
	public String detailqna(
			@ModelAttribute AdminQnaBoardDto adminQnaBoardDto,
			Model model
			) {
		try {
			
		AdminQnaBoardDto result = boardDao.qnaBoardGetOne(adminQnaBoardDto);
		model.addAttribute("one", result);
		
		return "board/detailqna";
		} catch (Exception e) {
			e.printStackTrace();
			return "board/detailqna";
		}
	}
	
	//관리문의 게시판 글작성하기
	@GetMapping("write")
	public String write(
			@RequestParam(value = "admin_qna_no", required = false, defaultValue = "0") int admin_qna_no,
			Model model
			) {
		try {
			
		if(admin_qna_no > 0) {
			model.addAttribute(admin_qna_no);
		}
		return "board/write";
		} catch (Exception e) {
			e.printStackTrace();
			return "board/write";
		}
	}
	
	@PostMapping("write")
	public String write(
			@ModelAttribute AdminQnaBoardDto adminQnaBoardDto,
			@RequestParam(value = "admin_qna_no1", required = false, defaultValue = "0") int admin_qna_no,
			HttpSession session
			) {
		try {
			
		log.info("adminqna={}",adminQnaBoardDto);
		log.info("admin_qna_no={}",admin_qna_no);
		String id = (String)session.getAttribute("admin_id");
		AdminDto adminDto = AdminDto.builder().admin_id(id).build();
		AdminDto admin = adminDao.login(adminDto);
		int admin_no = admin.getAdmin_no();
		adminQnaBoardDto.setAdmin_no(admin_no);
		if(admin_qna_no > 0) {
			//답글이다
			adminQnaBoardDto.setGroup_no(admin_qna_no);
			adminQnaBoardDto.setSuper_no(admin_qna_no);
			boardDao.qnaBoardInsertSecond(adminQnaBoardDto);
		}
		else {
			//admin_no를 가져온다
			boardDao.qnaBoardInsertNew(adminQnaBoardDto);
		}
		return "redirect:/board/manageqna";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/board/manageqna";
		}
	}
	
//	qna게시판 글 수정
	@GetMapping("/editqna")
	public String edit(
			@RequestParam(value = "admin_qna_no1", required = false, defaultValue = "0") int admin_qna_no,
			Model model
			) {
		try {
			
			AdminQnaBoardDto adminQnaBoardDto = AdminQnaBoardDto.builder()
																										.admin_qna_no(admin_qna_no)
																										.build();
			AdminQnaBoardDto result = boardDao.qnaBoardGetOne(adminQnaBoardDto);
			model.addAttribute("one", result);
			
			return "board/editqna";
		} catch (Exception e) {
			e.printStackTrace();
			return "board/editqna";
		}
		}
	@PostMapping("/editqna")
	public String edit(
			@RequestParam(value = "admin_qna_no1", required = false, defaultValue = "0") int admin_qna_no,
			@ModelAttribute AdminQnaBoardDto adminQnaBoardDto) {
		try {
			
			log.info("no = {}",admin_qna_no);
			adminQnaBoardDto.setAdmin_qna_no(admin_qna_no);
			log.info("board={}", adminQnaBoardDto);
			boardDao.qnaBoardUpdate(adminQnaBoardDto);

			return "redirect:/board/detailqna?admin_qna_no="+admin_qna_no;
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/board/detailqna?admin_qna_no="+admin_qna_no;
		}
	}
	
	//관리문의게시판 글 삭제
	@GetMapping("/delete")
	public String delete(
			@RequestParam(value = "admin_qna_no1", required = false, defaultValue = "0") int admin_qna_no) {
		try {
			
		AdminQnaBoardDto adminQnaBoardDto = AdminQnaBoardDto.builder()
																			.admin_qna_no(admin_qna_no)
																			.build();
		boardDao.qnaBoardDelete(adminQnaBoardDto);
		
		return "redirect:/board/manageqna";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/board/manageqna";
		}
	}
	
	//-------------------리뷰게시판------------------------------------------------
	@GetMapping("/review")
	public String review() {
		try {
			
		return "board/review";
		} catch (Exception e) {
			e.printStackTrace();
			return "board/review";
		}
	}
	
}
