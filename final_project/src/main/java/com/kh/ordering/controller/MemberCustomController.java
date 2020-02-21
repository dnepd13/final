package com.kh.ordering.controller;


import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;

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

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.repository.CategoryDao;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.FilesPhysicalDao;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.service.MemberCustomService;
import com.kh.ordering.service.SellerCustomService;
import com.kh.ordering.vo.CustomOrderVO;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberCustomController {
	
	@Autowired
	private MemberCustomService memberCustomService;	
	@Autowired
	private MemberCustomDao memberCustomDao;
	
	@Autowired
	private FilesDao filesDao;
	@Autowired
	private FilesPhysicalDao filesPhysicalDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private SellerCustomService sellerCustomService;
	@Autowired
	private SellerCustomDao sellerCustomDao;

//	주문제작 요청서 작성
	@GetMapping("/customCate") // 카테고리
	public String customCate(Model model, HttpSession session) {
		model.addAttribute("category_largeList", categoryDao.getList("category_large", "-"));
		
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		model.addAttribute("member_no", member_no);
		
		return "member/customCate";
	}
	@PostMapping("/customCate")
	public String customCate(HttpSession session, String category_name,
													@ModelAttribute CustomOrderDto customOrderDto,
													@ModelAttribute FilesVO files) throws IllegalStateException, IOException {
		
		//	small 이름으로 카테고리 번호 가져오기
		CategoryDto categoryDto = categoryDao.get(category_name); 
		int category_no = categoryDto.getCategory_no();
		
		customOrderDto.setCustom_order_category(category_no);

		memberCustomService.customCate(category_no, session, customOrderDto, files);
		
		return "redirect:/member/customSuccess";
	}
	
	@GetMapping("/customOrder") // 1:1 요청서. goodsInfo 페이지에서 접속가능
	public String memberCustom(HttpSession session,
															@RequestParam int seller_no,
															Model model) {
		
		model.addAttribute("seller_no", seller_no);
		
		return "member/customOrder";
	}	
	@PostMapping("/customOrder")
	public String memberCustom(HttpSession session, 
												@RequestParam int seller_no,
												@ModelAttribute FilesVO files,
												@ModelAttribute CustomOrderDto customOrderDto,
												@ModelAttribute SellerCustomAlarmDto sellerCustomAlarmDto) throws IllegalStateException, IOException {

		// 구매자 요청서 보내기
		// 요청서 작성 --> 주문제작 테이블 데이터 입력 --> 관리테이블 데이터 등록 --> 판매자 알람 테이블 등록
		memberCustomService.MemberCustom(session, seller_no,files, customOrderDto, sellerCustomAlarmDto);
		
		return "redirect:/member/customSuccess";
	}

//	작성 완료시 안내 페이지
	@GetMapping("/customSuccess")
	public String getSuccess() {
		return "member/customSuccess";
	}

//	목록 조회
	@GetMapping("/customListResp") // 받은 견적서 목록
	public String getListCustomResp(Model model, HttpSession session,
																@RequestParam(value="pageNo", required=false, defaultValue="0") String pageNo) {
		
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		PagingVO result = memberCustomService.customRespPaging(pageNo, member_no);
		model.addAttribute("paging", result);
		
		// 알람 check N count 개수		
		model.addAttribute("customAlarm", memberCustomDao.customAlarm(member_no));

		// 1:1 받은 견적서
		List<CustomOrderVO> list = memberCustomDao.getListResp(result);
		model.addAttribute("getListResp", list);		
		
		return "member/customListResp";
	}
	@GetMapping("/customInfoResp") // 받은 견적서 상세
	public String memberCustomResp(HttpSession session,
																	@RequestParam int seller_custom_order_no, Model model) {
		// 상세페이지 이동하면 구매자 알람테이블의 '알람체크','알람 확인시간' update
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		memberCustomDao.updateAlarm(member_no, seller_custom_order_no);
		
		CustomOrderVO content = memberCustomDao.customOrderVO1(seller_custom_order_no);
		model.addAttribute("getListInfoResp", content);
		
		List<FilesVO>  filesVO = sellerCustomService.filesList(seller_custom_order_no);
		model.addAttribute("filesVO", filesVO);
		
		return "member/customInfoResp";
	}

	@GetMapping("/customListReq") // 보낸 요청서 목록
	public String getListCustomReq(Model model, HttpSession session,
															@RequestParam(value="pageNo", required=false, defaultValue="0") String pageNo) {
		
		String member_id=(String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		PagingVO result = memberCustomService.customReqPaging(pageNo, member_no);
		model.addAttribute("paging", result);
		
		// 알람 check N count 개수		
		model.addAttribute("customAlarm", memberCustomDao.customAlarm(member_no));
		
		// 내가 보낸 요청서		
		List<CustomOrderVO> list = memberCustomDao.getListReq(result);
		model.addAttribute("getListReq", list);
		
		return "member/customListReq";
	}
	
	@GetMapping("/customInfoReq") // 보낸 요청서 상세
	public String memberCustomReq(@RequestParam int member_custom_order_no, Model model) {
		
		CustomOrderVO content = memberCustomDao.customOrderVO2(member_custom_order_no);
		model.addAttribute("getListInfoReq", content);

			// 카테고리 표시를 위한 model정보
		int category_no = content.getCustom_order_category();
		model.addAttribute("category", categoryDao.get(category_no));
		
		List<FilesVO>  filesVO = memberCustomService.filesList(member_custom_order_no);
		model.addAttribute("filesVO", filesVO);
		
		model.addAttribute("alarm", sellerCustomDao.getsellerAlarm(member_custom_order_no));
		
		return "member/customInfoReq";
	}

//	수정

	@PostMapping("/updateCustom")
	public String updateCustom(CustomOrderVO customOrderVO) {
		int member_custom_order_no = customOrderVO.getMember_custom_order_no();
		int custom_order_no = memberCustomDao.getCustomNo(member_custom_order_no);

		CustomOrderDto customOrderDto
				= CustomOrderDto.builder()
												.custom_order_no(custom_order_no)
												.custom_order_title(customOrderVO.getCustom_order_title())
												.custom_order_content(customOrderVO.getCustom_order_content())
												.custom_order_price(customOrderVO.getCustom_order_price())
												.custom_order_hopedate(customOrderVO.getCustom_order_hopedate())
												.build();
		memberCustomDao.updateCustom(customOrderDto);
		
		return "redirect:/member/customInfoReq?member_custom_order_no="+member_custom_order_no;
	}

//	삭제
	@GetMapping("/deleteReq") // 보낸 요청서 삭제(1:1)
	public String CustomDeleteReq(int member_custom_order_no) {

		// member_custom_order_no를 이용하여 custom_order_no 가져오기
		int custom_order_no = memberCustomDao.getCustomNo(member_custom_order_no);

//		 해당 주문제작 테이블 데이터 삭제
		memberCustomDao.deleteCustomReq(custom_order_no);
		
		return "member/customInfoReq";
	}
	@GetMapping("/deleteCustom")
	public String CustomDeleteCate(int member_custom_order_no) {		
		memberCustomDao.deleteAlarm(member_custom_order_no); // 판매자의 요청서 알람테이블 삭제
		memberCustomDao.deleteCustom(member_custom_order_no); // 주문제작 테이블 삭제
		return "member/customInfoReq";
	}
	
// 파일 이미지 다운로드
	@GetMapping("/download")
	public ResponseEntity<ByteArrayResource> CustomReqFile(@RequestParam int files_no) throws IOException{

		// 파일 no로 파일 정보 가져오기
		FilesDto filesDto = filesDao.getFiles(files_no);

		// 파일 이름 가져오기
		byte[] data = filesPhysicalDao.get(files_no);
		if(data==null) { // data 없으면 404처리
			return ResponseEntity.notFound().build();
		}
		
		ByteArrayResource resource = new ByteArrayResource(data);

		return ResponseEntity.ok()
												.contentType(MediaType.APPLICATION_OCTET_STREAM)
												.contentLength(filesDto.getFiles_size())
												.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+URLEncoder.encode(filesDto.getFiles_savename(),"UTF-8")+"\"")
												.body(resource);
		
	}

}