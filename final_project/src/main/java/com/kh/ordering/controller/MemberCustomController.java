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
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.SellerCategoryDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.CategoryDao;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.FilesPhysicalDao;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.OrderDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.MemberCustomService;
import com.kh.ordering.service.SellerCustomService;
import com.kh.ordering.vo.CartInfoVO;
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
	private MemberDao memberDao;
	
	@Autowired
	private FilesDao filesDao;
	@Autowired
	private FilesPhysicalDao filesPhysicalDao;
	
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private SellerCustomService sellerCustomService;
	@Autowired
	private SellerCustomDao sellerCustomDao;
	@Autowired
	private SellerDao sellerDao;
	
//	주문제작 요청서 작성
	@PostMapping("/sellerPick") // 판매자찾기
	@ResponseBody
	public List<SellerCategoryDto> sellerPick(@RequestParam(value = "category_name", required=false) String category_name) {
		
		// small 카테고리 이름으로 카테고리 정보 가져오기
		CategoryDto categoryDto = categoryDao.get(category_name); 
		// 카테고리 정보의 카테고리 번호와 그에 해당하는 판매자 정보 가져와서 보내기
		int category_no = categoryDto.getCategory_no();
		
//		List<SellerCategoryDto> getSellerNo = categoryDao.getSellerNo(category_no);
		
		return categoryDao.getSellerNo(category_no);
	}
	@PostMapping("/bestPick") // 추천판매자
	@ResponseBody
	public List<CartInfoVO> bestPick(@RequestParam(value = "category_name", required=false) String category_name) {
		
		// small 카테고리 이름으로 카테고리 정보 가져오기
		CategoryDto categoryDto = categoryDao.get(category_name); 
		// 카테고리 정보의 카테고리 번호와 그에 해당하는 판매자 정보 가져와서 보내기
		int category_no = categoryDto.getCategory_no();
		
		return orderDao.getTopSales(category_no);
	}
	@GetMapping("/customCate") // 카테고리
	public String customCate(Model model, HttpSession session,
													@RequestParam (value = "category_no", required=false) String category_name) {
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
		
		// 해당 견적서에 대한 주문제작 테이블 상태 "읽음" 업데이트
		SellerCustomOrderDto sellerCustomDto = sellerCustomDao.getSellerCustom(seller_custom_order_no);
		CustomOrderDto customOrderDto
												= CustomOrderDto.builder()
																					.custom_order_no(sellerCustomDto.getCustom_order_no())
																					.custom_order_status("읽음")
																					.build();
		memberCustomDao.updateCustomStatus(customOrderDto);

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
		
		List<SellerCustomAlarmDto> alarmList = sellerCustomDao.getSellerAlarm(member_custom_order_no);
		
		if(alarmList.size()==1) {
			SellerCustomAlarmDto alarm = SellerCustomAlarmDto.builder()
																											.seller_no(alarmList.get(0).getSeller_no())
																											.seller_alarm_no(alarmList.get(0).getSeller_no())
																											.seller_alarm_check(alarmList.get(0).getSeller_alarm_check())
																											.build(); 			
			model.addAttribute("alarm", alarm);
			
			int seller_no = alarmList.get(0).getSeller_no();
			SellerDto sellerDto= sellerDao.sellerDto(seller_no);
			String seller_id = sellerDto.getSeller_id();
			model.addAttribute("seller_id", seller_id);

			return "member/customInfoReq";
		}
		
		return "member/customInfoReq";
	}

//	수정
	@PostMapping("/updateReq")
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
	@GetMapping("/deleteReq") // 보낸 요청서 삭제
	public String CustomDeleteReq(HttpSession session,
																@RequestParam int member_custom_order_no) {

//		 해당 주문제작 테이블 데이터 삭제
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		MemberCustomOrderDto memberCustomDto
												= MemberCustomOrderDto.builder()
																									.member_no(member_no)
																									.member_custom_order_no(member_custom_order_no)
																									.build();
		memberCustomDao.deleteCustomReq(memberCustomDto);
		
		return "redirect:/member/customInfoReq";
	}

	// 받은 견적서 삭제 (받은 견적서 알람테이블 삭제)
	@GetMapping("/deleteResp")
	public String deleteCustomResp(@RequestParam int member_no,
															 	@RequestParam int seller_custom_order_no) {
		
		memberCustomDao.updateRespDelete(member_no, seller_custom_order_no);
		return "redirect:/member/customListResp";
	}
	
	// 받은 견적서 알람. (aside에서 비동기로 부를 것)
	@GetMapping("/alarmCount")
	@ResponseBody
	public int alarmCount(HttpSession session, Model model) {
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);

		// 회원 신규 견적서 알람 check N count 개수		
		return memberCustomDao.customAlarm(member_no);
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