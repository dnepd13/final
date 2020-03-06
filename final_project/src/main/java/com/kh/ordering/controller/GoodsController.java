package com.kh.ordering.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.entity.GoodsQnaDto;
import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.entity.GoodsReviewFilesDto;
import com.kh.ordering.entity.GoodsReviewReplyDto;
import com.kh.ordering.repository.CategoryDao;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.GoodsOptionDao;
import com.kh.ordering.repository.GoodsQnaDao;
import com.kh.ordering.repository.GoodsReviewDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.DeliveryService;
import com.kh.ordering.service.GoodsReviewService;
import com.kh.ordering.service.GoodsService;
import com.kh.ordering.vo.DeliveryVO;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.GoodsFileVO;
import com.kh.ordering.vo.GoodsVO;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/goods")
@Slf4j
public class GoodsController {
	
	@Autowired
	private SellerDao sellerDao;
	
	@Autowired
	private FilesDao filesDao;
	
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
	
	// 정렬 나중에...
//	@GetMapping("/align")
//	public void align(@RequestParam String type) {
//		goodsService.align(type);
//	}
	
	// 파일 다운로드
	@GetMapping("/mainImageDown")
	public ResponseEntity<ByteArrayResource> mainImageDown(@RequestParam int files_no) throws IOException{
		File dir = new File("D:/upload/kh2d");
		File target = new File(dir, "goodsMain" + files_no);
		byte[] data = FileUtils.readFileToByteArray(target);
		
		if(data==null) {
			return ResponseEntity.notFound().build();
		}
		ByteArrayResource resource = new ByteArrayResource(data);
		
		FilesDto filesDto = filesDao.getFiles(files_no);
		
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(filesDto.getFiles_size())
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+URLEncoder.encode(filesDto.getFiles_savename(),"UTF-8")+"\"")
				.body(resource);
	}
	
	@GetMapping("/contentImageDown")
	public ResponseEntity<ByteArrayResource> contentImageDown(@RequestParam int files_no) throws IOException{
		File dir = new File("D:/upload/kh2d");
		File target = new File(dir, "goodsContent" + files_no);
		byte[] data = FileUtils.readFileToByteArray(target);
		
		if(data==null) {
			return ResponseEntity.notFound().build();
		}
		ByteArrayResource resource = new ByteArrayResource(data);
		
		FilesDto filesDto = filesDao.getFiles(files_no);
		
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(filesDto.getFiles_size())
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+URLEncoder.encode(filesDto.getFiles_savename(),"UTF-8")+"\"")
				.body(resource);
	}
	
	
	@GetMapping("/insert")
	public String insert(Model model, HttpSession session) {
		model.addAttribute("category_largeList", categoryDao.getList("category_large", "-"));
		model.addAttribute("seller_no", sellerDao.getSellerNo((String)session.getAttribute("seller_id")));
		return "goods/insert";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute GoodsVO goodsVO, 
						@ModelAttribute DeliveryVO deliveryVO,
						@RequestParam MultipartFile goods_main_image,
						@RequestParam MultipartFile[] goods_content_image
						) throws IllegalStateException, IOException {
		// 상품 처리
		int goods_no = goodsService.insert(goodsVO);
		deliveryVO.setGoods_no(goods_no);
		deliveryService.insert(deliveryVO);
		
		// 파일 처리
		int files_no = goodsService.insertFiles(goods_main_image, goods_no);
		List<Integer> list = goodsService.insertFiles(goods_content_image, goods_no);
		
		// 물리 저장 처리
		//파일 저장 : 저장을 할 가상의 파일 객체가 필요
		//저장경로 : D:/upload
		File dir = new File("D:/upload/kh2d");
		dir.mkdirs();//디렉터리 생성
		
		File target = new File(dir, "goodsMain" + files_no);
		goods_main_image.transferTo(target);//파일 저장
		
		for(int i = 0; i<list.size(); i++) {
			File tg = new File(dir, "goodsContent" + list.get(i));
			goods_content_image[i].transferTo(tg);
		}
		
		int page_no = goodsDao.getSequence();
		
		return "redirect:goodsInfo?goods_no=" + page_no;
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
		
		
		model.addAttribute("listNew", goodsService.getListNew());
		model.addAttribute("listBest", goodsService.getListBest());
		
		// 전체 상품
		List<GoodsDto> list = goodsService.getList();
		List<GoodsFileVO> VOlist = new ArrayList<>();
		for (GoodsDto goodsDto : list) {
			GoodsFileVO goodsFileVO = GoodsFileVO.builder()
					.goodsDto(goodsDto)
					.goods_main_image(goodsDao.getGoodsMainImage(goodsDto.getGoods_no()))
					.build();
			VOlist.add(goodsFileVO);
		}
		model.addAttribute("list", VOlist);
//		model.addAttribute("VOList", VOlist);
		return "goods/getList";
	}
	
	@GetMapping("/goodsInfo")
	public String goodsInfo(@RequestParam int goods_no, Model model, HttpSession session,
												@RequestParam(value = "pageNo", required=false, defaultValue="0")String pageNo) throws JsonProcessingException {
		String jsonGoodsVO = new ObjectMapper().writeValueAsString(goodsService.getGoodsVO(goods_no));
		String jsonGoodsOptionVOList = new ObjectMapper().writeValueAsString(goodsService.getGoodsOptionVOList(goods_no));
		
		model.addAttribute("goodsVO", goodsService.getGoodsVO(goods_no));
		model.addAttribute("goodsOptionVOList", goodsService.getGoodsOptionVOList(goods_no));
		model.addAttribute("jsonGoodsVO", jsonGoodsVO);
		model.addAttribute("jsonGoodsOptionVOList", jsonGoodsOptionVOList);
		
		model.addAttribute("files_no", goodsDao.getGoodsMainImage(goods_no));
		
		if(goodsDao.getContentImage(goods_no).size()>0) {
			model.addAttribute("content_image", goodsDao.getContentImage(goods_no));
		}
		// 적립금
		int rate = 1;
		if((String)session.getAttribute("member_id") != null) {
			rate = memberDao.getGradeBenefitRate(memberDao.getMemberGrade(memberDao.getNo((String)session.getAttribute("member_id"))));
		}
		model.addAttribute("rate", rate);
		//	문의, 리뷰 게시판 ...... 세션아이디 없어도 들어갈 수 있게 ..........ㅎ....
		String member_id=(String)session.getAttribute("member_id");
		String seller_id = (String)session.getAttribute("seller_id");
		if(member_id!=null) { // 판매자 로그인 상태일 때 세션에서 seller_id 가져와서 비교		
			int member_no = memberDao.getNo(member_id);
			model.addAttribute("member_no",member_no);
		}
		else if(seller_id!=null){
			int seller_no = sellerCustomDao.getNo(seller_id);
			model.addAttribute("seller_no", seller_no);				
		}

			PagingVO result = goodsService.goodsQnaPaging(pageNo, goods_no);
			model.addAttribute("paging", result);			
			List<GoodsQnaDto> goodsQna = goodsQnaDao.getListQna(result);
			model.addAttribute("goodsQna", goodsQna);
			
			List<GoodsReviewDto> goodsReview = goodsReviewDao.getReview(goods_no);
			model.addAttribute("goodsReview", goodsReview); // 리뷰 목록
			
			// 리뷰 댓글
			List<GoodsReviewReplyDto> reviewReply = new ArrayList<>();
			for(GoodsReviewDto review : goodsReview) {
				reviewReply.addAll(goodsReviewDao.getListReply(review.getGoods_review_no()));
				model.addAttribute("reviewReply", reviewReply);
			}
			// 리뷰 파일
			List<FilesVO> reviewFiles = new ArrayList<>();
			for(GoodsReviewDto review : goodsReview) {
				reviewFiles.addAll(goodsReviewService.filesList(review.getGoods_review_no()));
				model.addAttribute("filesVO", reviewFiles);
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

// 리뷰 댓글 등록
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
