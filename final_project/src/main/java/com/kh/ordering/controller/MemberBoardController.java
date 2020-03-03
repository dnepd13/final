package com.kh.ordering.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.AdminQnaDto;
import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.repository.AdminQnaDao;

import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.service.BoardQnaService;
import com.kh.ordering.vo.PageVo;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class MemberBoardController {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private AdminQnaDao adminQnaDao;

	@Autowired
	private BoardQnaService boardQnaService;

	@Autowired
	private SqlSession sqlSession;

	//신고 게시판 처리
	@GetMapping("/memberreport")
	public String memberreport(HttpSession session, Model model,
					@RequestParam(value="pno1", required = false)
					String pno1
					) {

		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);	
//		log.info("no={}",member_no);

		PagingVO pagingVO = boardQnaService.adminQnaPagination(pno1,member_no);

	int member_no1 = memberDao.getNo(member_id);
//	log.info("nore1={}",member_no1);

	pagingVO.setMember_no(member_no);

//	log.info("pagingVO={}",pagingVO);

	List<AdminQnaDto> reportlist = adminQnaDao.getListReport(pagingVO);
//	log.info("reportlist={}",reportlist);



	model.addAttribute("getListReport",reportlist);
	model.addAttribute("paging",pagingVO);
//	log.info("1={}",model);

		return "board/memberreport";
	}

	//문의 게시판 처리
	@GetMapping("/memberqna")
	public String memberqna(HttpSession session, Model model,
					@RequestParam(value="pno1", required = false)
					String pno1
					) {

		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);

		PagingVO pagingVO = boardQnaService.QnaPagination(pno1, member_no);
		pagingVO.setMember_no(member_no);

		List<AdminQnaDto> qnalist = adminQnaDao.getListQna(pagingVO);


		model.addAttribute("getListQna",qnalist);
		model.addAttribute("paging1",pagingVO);

		return "board/memberqna";
		}



	//신고 상세보기
	@GetMapping("/detailreport")
	public String detailreport(
			@ModelAttribute AdminQnaDto adminQnaDto,
			Model model
			) {
		AdminQnaDto result = adminQnaDao.qnaBoardGetOne(adminQnaDto);
//		log.info("result={}",result);
		model.addAttribute("reportone", result);

		return "board/detailreport";
	}



	//문의 상세보기
	@GetMapping("/detailmqna")
	public String detailmqna(
			@ModelAttribute AdminQnaDto adminQnaDto,
			Model model
			) {
		AdminQnaDto result1 = adminQnaDao.qnaGetOne(adminQnaDto);
//		log.info("result={}",result1);

		model.addAttribute("qnaone",result1);

		return "board/detailmqna";
	}


	//문의 게시판 인서트
	@GetMapping("/qnaregist")
	public String qnaregist()
	{


		return "board/qnaregist";
	}
	
	
	

	@PostMapping("/qnaregist")
	public String qnaregist(@ModelAttribute AdminQnaDto adminQnaDto,
							HttpSession session, Model model)
	{

		//회원 문의 시퀀스 저장
		int qnaseq = adminQnaDao.QnaSeq();

		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);

//		adminQnaDto.setAdmin_qna_no(qnaseq);

		//중복되어있는 dto라 사용자가 작성한 Dto 데이터가 지워지고 다시 세팅되는 역활을 함
//		adminQnaDto = AdminQnaDto.builder()
//								.admin_qna_no(qnaseq)
//								.member_no(member_no)
//								.group_no(qnaseq)
//								.admin_qna_writer(member_id)
//								.build();

		adminQnaDto.setAdmin_qna_no(qnaseq);
		adminQnaDto.setMember_no(member_no);
		adminQnaDto.setGroup_no(qnaseq);
		adminQnaDto.setAdmin_qna_writer(member_id);
		adminQnaDto.setSuper_no(qnaseq);

//		log.info("adminQnaDtoGroup={}",qnaseq);
//		log.info("adminQnaDtore={}",adminQnaDto);
//
//		log.info("adminQnaDtoregi={}",adminQnaDto);
////		model.addAttribute("insertQna", adminQnaDto);
//		log.info("modelregi={}",model);



		adminQnaDao.qnaregist(adminQnaDto);
//	sqlSession.insert("adminQnaDto.qnaregist",adminQnaDto);

//		log.info("modelfinal={}",adminQnaDto);

	return "redirect:/board/memberqna";
}




	// 회원 문의게시판 수정
	@GetMapping("/editqna")
	public String editqna(@RequestParam int admin_qna_no,Model model) {
//		log.info("upno={}", admin_qna_no);

		AdminQnaDto result = adminQnaDao.qnagetUpdate(admin_qna_no);
//		log.info("resultup={}",result);
		model.addAttribute("updateget",result);

//		log.info("modelup={}",result);

		return "board/editqna";
	}

	@PostMapping("/editqna")
	public String editqna(@ModelAttribute AdminQnaDto adminQnaDto,
							Model model ) {

		log.info("adimbefor={}",adminQnaDto);

//		AdminQnaDto result = adminQnaDao.qnagetupdate(adminQnaDto);


		log.info("model={}", model);


//		log.info("uppoDto= {}",adminQnaDto);
//		log.info("resultpo={}",result);
		adminQnaDao.qnaUpdate(adminQnaDto);

		return "redirect:/board/memberqna";
	}
	
	
	@GetMapping("/deleteqna")
	public String deleteqna()
	{
		return "/board/deleteqna";
	}
	@PostMapping("/deleteqna")
	public String deleteqna(@ModelAttribute AdminQnaDto adminQnaDto)
	{
		log.info("deleteno={}",adminQnaDto);
		adminQnaDao.deleteqna(adminQnaDto);
		
		return "redirect:/board/memberqna";
	}
	
}
	
