package com.kh.ordering.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ordering.entity.GoodsQnaDto;
import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.entity.GoodsReviewReplyDto;
import com.kh.ordering.repository.CategoryDao;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.GoodsOptionDao;
import com.kh.ordering.repository.GoodsQnaDao;
import com.kh.ordering.repository.GoodsReviewDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.service.DeliveryService;
import com.kh.ordering.service.GoodsReviewService;
import com.kh.ordering.service.GoodsService;
import com.kh.ordering.vo.DeliveryVO;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.GoodsVO;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/goods")
@Slf4j
public class GoodsController {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private DeliveryService deliveryService;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private GoodsQnaDao goodsQnaDao;
	@Autowired
	private SellerCustomDao sellerCustomDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private GoodsReviewDao goodsReviewDao;
	@Autowired
	private GoodsReviewService goodsReviewService;
	
	@GetMapping("/insert")
	public String insert(Model model) {
		model.addAttribute("category_largeList", categoryDao.getList("category_large", "-"));
		return "goods/insert";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute GoodsVO goodsVO, @ModelAttribute DeliveryVO deliveryVO) {
		int goods_no = goodsService.insert(goodsVO);
		deliveryVO.setGoods_no(goods_no);
		deliveryService.insert(deliveryVO);
		return "redirect:goodsInfo?goods_no=" + goods_no;
	}
	
	@GetMapping("/get")
	public String get(@RequestParam int goods_no, Model model) {
		model.addAttribute("goodsDto", goodsService.get(goods_no));
		return "goods/get";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam int goods_no) {
		goodsService.delete(goods_no);
		return "redirect:list";
	}
	
	@GetMapping("/getList")
	public String getList(Model model) {
		model.addAttribute("list", goodsService.getList());
		return "goods/getList";
	}
	
	@GetMapping("/goodsInfo")
	public String goodsInfo(HttpSession session,
												@RequestParam int goods_no, Model model,
												@RequestParam(value = "pageNo", required=false, defaultValue="0")String pageNo) throws JsonProcessingException {
		String jsonGoodsVO = new ObjectMapper().writeValueAsString(goodsService.getGoodsVO(goods_no));
		String jsonGoodsOptionVOList = new ObjectMapper().writeValueAsString(goodsService.getGoodsOptionVOList(goods_no));
		
		model.addAttribute("goodsVO", goodsService.getGoodsVO(goods_no));
		model.addAttribute("goodsOptionVOList", goodsService.getGoodsOptionVOList(goods_no));
		model.addAttribute("jsonGoodsVO", jsonGoodsVO);
		model.addAttribute("jsonGoodsOptionVOList", jsonGoodsOptionVOList);

//	문의, 리뷰 게시판 ...... 세션아이디 없어도 들어갈 수 있게 ..........ㅎ....
		String member_id=(String)session.getAttribute("member_id");
		String seller_id = (String)session.getAttribute("seller_id");
		if(member_id!=null) { // 판매자 로그인 상태일 때 세션에서 seller_id 가져와서 비교		
			int member_no = memberDao.getNo(member_id);
			model.addAttribute("member_no",member_no);
			
			// 문의
			PagingVO result = goodsService.goodsQnaPaging(pageNo, goods_no);
			model.addAttribute("paging", result);			
			List<GoodsQnaDto> goodsQna = goodsQnaDao.getListQna(result);
			model.addAttribute("goodsQna", goodsQna);
			
			// 리뷰
			List<GoodsReviewDto> goodsReview = goodsReviewDao.getReview(goods_no);
			model.addAttribute("goodsReview", goodsReview);
			List<FilesVO>  filesVO = goodsReviewService.filesList(goods_no);
			model.addAttribute("filesVO", filesVO);
		}
		else if(seller_id!=null){
			int seller_no = sellerCustomDao.getNo(seller_id);
			model.addAttribute("seller_no", seller_no);	
			
			PagingVO result = goodsService.goodsQnaPaging(pageNo, goods_no);
			model.addAttribute("paging", result);			
			List<GoodsQnaDto> goodsQna = goodsQnaDao.getListQna(result);
			model.addAttribute("goodsQna", goodsQna);
			
			List<GoodsReviewDto> goodsReview = goodsReviewDao.getReview(goods_no);
			model.addAttribute("goodsReview", goodsReview);
			List<FilesVO>  filesVO = goodsReviewService.filesList(goods_no);
			model.addAttribute("filesVO", filesVO);
		}
		else {
			PagingVO result = goodsService.goodsQnaPaging(pageNo, goods_no);
			model.addAttribute("paging", result);			
			List<GoodsQnaDto> goodsQna = goodsQnaDao.getListQna(result);
			model.addAttribute("goodsQna", goodsQna);
			
			List<GoodsReviewDto> goodsReview = goodsReviewDao.getReview(goods_no);
			model.addAttribute("goodsReview", goodsReview);
			List<FilesVO>  filesVO = goodsReviewService.filesList(goods_no);
			model.addAttribute("filesVO", filesVO);
		}	
		
		return "goods/goodsInfo";
	}
	
	@PostMapping("/large")
	@ResponseBody
	public List<String> large(@RequestParam String category_name) {
		return categoryDao.getList("category_middle", category_name);
	}
	
	@PostMapping("/middle")
	@ResponseBody
	public List<String> middle(@RequestParam String category_name) {
		return categoryDao.getList("category_small", category_name);
	}
	
	@PostMapping("/small")
	@ResponseBody
	public int small(@RequestParam String category_name) {
		return categoryDao.get(category_name).getCategory_no();
	}

//////////////////	상품 문의 게시판	//////////////////////
	@PostMapping("/insertQ") // 구매자 문의 입력
	public String insertQ(HttpSession session, 
											@ModelAttribute GoodsQnaDto goodsQnaDto) {
		
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);
		
		goodsQnaDto.setGoods_qna_writer(member_id);		
		goodsQnaDto.setMember_no(member_no);
		
		goodsQnaDao.insertQ(goodsQnaDto);
		
		return "redirect:goodsInfo?goods_no="+goodsQnaDto.getGoods_no();
	}
	@PostMapping("/updateQ") // 구매자 문의 수정
	public String updateQ(HttpSession session, int goods_no,
											@ModelAttribute GoodsQnaDto goodsQnaDto) {
		
		goodsQnaDao.updateQ(goodsQnaDto);
		
		return "redirect:goodsInfo?goods_no="+goods_no;
	}
	@GetMapping("/deleteQ") // 구매자 문의 삭제
	public String deleteQ(HttpSession session, int goods_qna_no, int goods_no) {
		
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);
		
		GoodsQnaDto goodsQnaDto = new GoodsQnaDto();
								goodsQnaDto.setMember_no(member_no);
								goodsQnaDto.setGoods_qna_no(goods_qna_no);
		goodsQnaDao.deleteQ(goodsQnaDto);
		
		return "redirect:goodsInfo?goods_no="+goods_no;
	}
	
	@PostMapping("/insertA") // 판매자 답변
	public String insertA(HttpSession session, 
											@ModelAttribute GoodsQnaDto goodsQnaDto,
											@RequestParam int goods_no) {
		
		String seller_id = (String)session.getAttribute("seller_id");
		
		goodsQnaDto.setGoods_qna_groupno(goodsQnaDto.getGoods_qna_groupno());
		goodsQnaDto.setGoods_qna_superno(goodsQnaDto.getGoods_qna_no());
		goodsQnaDto.setGoods_qna_writer(seller_id);		
		goodsQnaDao.insertA(goodsQnaDto);
		
		int goods_qna_groupno = goodsQnaDto.getGoods_qna_groupno();

		goodsQnaDao.getIsQna(goods_qna_groupno);
		
		return "redirect:goodsInfo?goods_no="+goodsQnaDto.getGoods_no();
	}

// 리뷰 댓글
	@PostMapping("/insertReply")
	public String insertReply(HttpSession session,
													@ModelAttribute GoodsReviewReplyDto goodsReviewReplyDto,
													int goods_review_no) {
		
		String member_id = (String)session.getAttribute("member_id");
		int member_no= memberDao.getNo(member_id);
		
		goodsReviewReplyDto.setMember_no(member_no);
		goodsReviewReplyDto.setGoods_review_reply_writer(member_id);
		goodsReviewDao.insertReviewReply(goodsReviewReplyDto);
		
		int goods_no = goodsReviewDao.getGoodsNoReview(goods_review_no);
		
		return "redirect:/goods/goodsInfo?goods_no="+goods_no;
	}
	
	
}
