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
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.AdminQnaDao;

import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.BoardQnaService;
import com.kh.ordering.vo.PageVo;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class MemberBoardController {

	
	@Autowired
	private SellerDao sellerDao;
	
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
////		log.info("no={}",member_no);

		PagingVO pagingVO = boardQnaService.adminQnaPagination(pno1,member_no);

	int member_no1 = memberDao.getNo(member_id);
////	log.info("nore1={}",member_no1);

	pagingVO.setMember_no(member_no);

//	log.info("pagingVO={}",pagingVO);

	List<AdminQnaDto> reportlist = adminQnaDao.getListReport(pagingVO);
////	log.info("reportlist={}",reportlist);



	model.addAttribute("getListReport",reportlist);
	model.addAttribute("paging",pagingVO);
////	log.info("1={}",model);

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

		log.info("qnalist={}",qnalist);

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
		AdminQnaDto result = adminQnaDao.ReportGetOne(adminQnaDto);
//		log.info("result={}",result);
		model.addAttribute("ReportGetOne", result);
		log.info("modalreport1={}",model);
		return "board/detailreport";
	}



	//문의 상세보기
	@GetMapping("/detailmqna")

	public String detailmqna(
			@ModelAttribute AdminQnaDto adminQnaDto,
			Model model,HttpSession session
			) {

		log.info("admindto={}", adminQnaDto);
		log.info("sessionid={}", session);
		String member_id = (String)session.getAttribute("member_id");
		int getNo = memberDao.getNo(member_id);
		log.info("getNO={}", getNo);
		AdminQnaDto result1 = adminQnaDao.qnaGetOne(adminQnaDto,getNo);
		log.info("result11={}", result1);          
		
		AdminQnaDto memberresult = adminQnaDao.qnaonemember(adminQnaDto);
		log.info("memberresult={}",memberresult);
		
		//세션에서 가져온 멤버no
		model.addAttribute("memberno",getNo);
		model.addAttribute("qnaone",result1);

		
		//리스트에서 가져온 memberNo
		model.addAttribute("qnaoneGetOne",result1);
		log.info("membersu={}",result1);
		
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
		log.info("adminQnaDto={}", adminQnaDto);
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
	@GetMapping("/updateqna")

	public String editqna(@RequestParam int admin_qna_no,Model model) {
		log.info("upno={}", admin_qna_no);

		AdminQnaDto result = adminQnaDao.qnagetUpdate(admin_qna_no);
//		log.info("resultup={}",result);
		model.addAttribute("updateget",result);
		
//		log.info("modelup={}",result);

		return "board/updateqna";
	}

	@PostMapping("/updateqna")
	public String editqna(@ModelAttribute AdminQnaDto adminQnaDto,
							Model model ) {


//		AdminQnaDto result = adminQnaDao.qnagetupdate(adminQnaDto);




//		log.info("uppoDto= {}",adminQnaDto);
//		log.info("resultpo={}",result);
		adminQnaDao.qnaUpdate(adminQnaDto);

		return "redirect:/board/memberqna";
	}
	
	

//	@GetMapping("/deleteqna")
//	public String deleteqna()
//	{
//		return "/board/deleteqna";
//	}
//	@PostMapping("/deleteqna")
//	public String deleteqna(@ModelAttribute AdminQnaDto adminQnaDto)
//	{
//		log.info("deleteno={}",adminQnaDto);
//		adminQnaDao.deleteqna(adminQnaDto);
//		
//		return "redirect:/board/memberqna";
//	}
	
	
	//신고 쓰기
		@GetMapping("/reportregist")
		public String reportregist()
		{


		return "board/reportregist";
		}
	
			@PostMapping("/reportregist")
			public String reportregist(@ModelAttribute AdminQnaDto adminQnaDto,
										HttpSession session, Model model)
			{
				//회원 신고 시퀀스 저장
			
						int qnaseq = adminQnaDao.QnaSeq();

						String member_id = (String)session.getAttribute("member_id");
						int member_no = memberDao.getNo(member_id);
						
						adminQnaDto.setAdmin_qna_no(qnaseq);
						adminQnaDto.setMember_no(member_no);
						adminQnaDto.setGroup_no(qnaseq);
						adminQnaDto.setAdmin_qna_writer(member_id);
						adminQnaDto.setSuper_no(qnaseq);
						adminQnaDao.reportregist(adminQnaDto);
			
						return "redirect:/board/memberreport";
			}
			
			
			// 회원 신고게시판 수정
			@GetMapping("/editreport")
			public String editreport(@RequestParam int admin_qna_no,Model model) {
				log.info("reportupno={}", admin_qna_no);

//				AdminQnaDto result1= AdminQnaDto.builder().admin_qna_no(admin_qna_no).build();
				
				AdminQnaDto result1 = adminQnaDao.reportgetupdate(admin_qna_no);
				log.info("resultupreportsuperno={}",result1);
				model.addAttribute("updategetreport",result1);
				
				log.info("modelupget11={}",result1);

				return "board/editreport";
			}

			
			@PostMapping("/editreport")
			public String editreport(@ModelAttribute AdminQnaDto adminQnaDto,
									Model model ) {

				log.info("adimbefor={}",adminQnaDto);

//				AdminQnaDto result = adminQnaDao.qnagetupdate(adminQnaDto);


				log.info("model={}", model);


//				log.info("uppoDto= {}",adminQnaDto);
//				log.info("resultpo={}",result);
				adminQnaDao.reportUpdate(adminQnaDto);

				return "redirect:/board/memberreport";
			}
	
	// 판매자 문의 게시판 처리
		@GetMapping("/sellerqna")

		public String sellerqna(HttpSession session, Model model,
						@RequestParam(value="pno2", required = false)
						String pno2
						) {

			String seller_id = (String)session.getAttribute("seller_id");
			int seller_no = sellerDao.getSellerNo(seller_id);

			PagingVO pagingVO = boardQnaService.QnaPagination1(pno2, seller_no);
			pagingVO.setSeller_no(seller_no);

			List<AdminQnaDto> qnalist = adminQnaDao.getListSellerQna(pagingVO);


			model.addAttribute("getListSellerQna",qnalist);
			model.addAttribute("paging",pagingVO);

			return "board/sellerqna";
			}
		
	
//		//판매 신고 게시판 처리
		@GetMapping("/sellerreport")
		public String sellerreport(HttpSession session, Model model,
						@RequestParam(value="pno2", required = false)
						String pno2
						) {

			String seller_id = (String)session.getAttribute("seller_id");
			int seller_no = sellerDao.getSellerNo(seller_id);	
//			log.info("sellerno={}",seller_no);

			PagingVO pagingVO = boardQnaService.adminQnaPagination1(pno2,seller_no);

			pagingVO.setSeller_no(seller_no);

			List<AdminQnaDto> sellerreportlist = adminQnaDao.getListSellerReport(pagingVO);

			model.addAttribute("getListSellerReport",sellerreportlist);
			model.addAttribute("paging",pagingVO);


			return "board/sellerreport";
		}	

				//판매자 신고 게시판 인서트
				@GetMapping("/sellerreportregist")
				public String sellerreportregist()
				{
					return "board/sellerreportregist";
				}
	
//				//판매자 신고 쓰기
				@PostMapping("/sellerreportregist")
				public String sellerreportregist(@ModelAttribute AdminQnaDto adminQnaDto,
											HttpSession session, Model model)
				{
					//판매자 신고 시퀀스 저장
				
							int qnaseq = adminQnaDao.QnaSeq();

							String seller_id = (String)session.getAttribute("seller_id");
							int seller_no = sellerDao.getSellerNo(seller_id);
							
							adminQnaDto.setAdmin_qna_no(qnaseq);
							adminQnaDto.setSeller_no(seller_no);
							adminQnaDto.setGroup_no(qnaseq);
							adminQnaDto.setAdmin_qna_writer(seller_id);
							adminQnaDto.setSuper_no(qnaseq);
							
							adminQnaDao.sellerreportregist(adminQnaDto);
				
							return "redirect:/board/sellerreport";
				}
		
				
				
	
					//판매자 신고 상세보기
				@GetMapping("/sellerdetailreport")
				public String sellerdetailreport(
						@ModelAttribute AdminQnaDto adminQnaDto,
						Model model
						) {
					AdminQnaDto sellerresult = adminQnaDao.sellerreportGetOne(adminQnaDto);
//					log.info("resultseller={}",result);
					model.addAttribute("sellerreportrone", sellerresult);

					return "board/sellerdetailreport";
				}
//				
//				
//				
//				
//				
//				//판매자 신고 게시판 수정
				@GetMapping("/sellereditreport")
				public String sellereditreport(@RequestParam int admin_qna_no,Model model) {
//					log.info("upsellerno={}", admin_qna_no);

					AdminQnaDto sellerresult = adminQnaDao.sellerreportgetupdate(admin_qna_no);
//					log.info("sellerresultup={}",sellerresult);
					model.addAttribute("sellerupdateget",sellerresult);

//					log.info("sellermodelup={}",sellerresult);

					return "board/sellereditreport";
				}
				
				@PostMapping("/sellereditreport")
				public String sellereditreport(@ModelAttribute AdminQnaDto adminQnaDto,
										Model model ) {

					log.info("selleradimbefor1={}",adminQnaDto);

//					AdminQnaDto result = adminQnaDao.qnagetupdate(adminQnaDto);


					log.info("sellermodel1={}", model);


//					log.info("uppoDto= {}",adminQnaDto);
//					log.info("resultpo={}",result);
					adminQnaDao.sellerreportUpdate(adminQnaDto);

					return "redirect:/board/sellerreport";
				}	
//				
//				
//				
//				
//				//판매자 문의 상세보기
				@GetMapping("/sellerdetailmqna")
		
				public String sellerdetailmqna(
						@ModelAttribute AdminQnaDto adminQnaDto,
						Model model
						) {
					AdminQnaDto sellerresult1 = adminQnaDao.sellerqnaGetOne(adminQnaDto);
//					log.info("seller1result={}",sellerresult1);

					model.addAttribute("sellerQnaGetOne",sellerresult1);

					return "board/sellerdetailmqna";
				}
		
		
//				//문의 게시판 인서트
				@GetMapping("/sellerqnaregist")
		
				public String sellerqnaregist()
				{
					return "board/sellerqnaregist";
				}
				
				
				

				@PostMapping("/sellerqnaregist")
				public String sellerqnaregist(@ModelAttribute AdminQnaDto adminQnaDto,
										HttpSession session, Model model)
				{

					//회원 문의 시퀀스 저장
					int qnaseq = adminQnaDao.QnaSeq();

					String seller_id = (String)session.getAttribute("seller_id");
					int seller_no = sellerDao.getSellerNo(seller_id);


					adminQnaDto.setAdmin_qna_no(qnaseq);
					adminQnaDto.setSeller_no(seller_no);
					adminQnaDto.setGroup_no(qnaseq);
					adminQnaDto.setAdmin_qna_writer(seller_id);
					adminQnaDto.setSuper_no(qnaseq);


					adminQnaDao.sellerqnaregist(adminQnaDto);
//				sqlSession.insert("adminQnaDto.qnaregist",adminQnaDto);

//					log.info("modelfinal={}",adminQnaDto);

				return "redirect:/board/sellerqna";
			}
		
		
		
//				// 판매자 문의게시판 수정
				@GetMapping("/sellereditqna")
				public String sellereditqna(@RequestParam int admin_qna_no,Model model) {
//					log.info("upno={}", admin_qna_no);

					AdminQnaDto sellerresult = adminQnaDao.sellerqnagetUpdate(admin_qna_no);
//					log.info("resultup={}",result);
					model.addAttribute("sellerupdateget",sellerresult);

//					log.info("modelup={}",result);

					return "board/sellereditqna";
				}

				@PostMapping("/sellereditqna")
				public String sellereditqna(@ModelAttribute AdminQnaDto adminQnaDto,
										Model model ) {

					log.info("selleradimbefor={}",adminQnaDto);



					log.info("sellermodel={}", model);


//					log.info("uppoDto= {}",adminQnaDto);
//					log.info("resultpo={}",result);
					adminQnaDao.sellerqnaUpdate(adminQnaDto);

					return "redirect:/board/sellerqna";
				}

// 공지사항 게시판
	@GetMapping("/notice")
	public String getListNotice(Model model,
													@RequestParam(value="pageNo", required=false, defaultValue="0") String pageNo){
		
		PagingVO result= boardQnaService.noticePaging(pageNo);
		model.addAttribute("paging", result);
		List<AdminQnaDto> getNotice = adminQnaDao.getListNotice(result);
		model.addAttribute("getNotice", getNotice);
		
		return "board/notice";
	}
	@GetMapping("/noticeDetails")
	public String getNoticeDetails(Model model,
															@RequestParam int admin_qna_no) {
		
		AdminQnaDto adminQnaDto = adminQnaDao.getNoticeDetails(admin_qna_no);
		model.addAttribute("notice", adminQnaDto);
		
		return "board/noticeDetails";
	}
	
}
	
