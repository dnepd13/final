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

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.repository.CategoryDao;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.FilesPhysicalDao;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.service.MemberCustomService;
import com.kh.ordering.service.SellerCustomService;
import com.kh.ordering.vo.CustomOrderVO;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/seller")
@Slf4j
public class SellerCustomController {
	
	@Autowired
	private SellerCustomService sellerCustomService;	
	@Autowired
	private SellerCustomDao sellerCustomDao;
	
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
	
// 주문제작 견적서 작성
	@GetMapping("/customOrder")
	public String memberCustom(@RequestParam int member_no,
															@RequestParam(value="category_no", required=false, defaultValue="0") int category_no,
															Model model) {

		model.addAttribute("member_no", member_no);
		model.addAttribute("category_no", category_no);
		
		return "seller/customOrder";
	}
		
	@PostMapping("/customOrder")
	public String memberCustom(HttpSession session,
														@RequestParam int member_no,
														@RequestParam int category_no,
														@ModelAttribute FilesVO files,
														@ModelAttribute CustomOrderDto customOrderDto) throws IllegalStateException, IOException {

		//판매자 견적서 보내기
		//견적서 작성 --> 주문제작 테이블 데이터 입력 --> 관리테이블 데이터 등록 --> 구매자 알람 테이블 등록
		sellerCustomService.SellerCustom(session, member_no, category_no, files, customOrderDto);
		return "redirect:/seller/customSuccess";
	}
//	작성 완료시 안내 페이지
	@GetMapping("/customSuccess")
	public String getSuccess() {
		return "seller/customSuccess";
	}
	
//	목록 조회
	@GetMapping("/customListReq") // 받은 요청서 목록
	public String getListCustomReq(Model model, HttpSession session,
														@RequestParam(value="pageNo", required=false, defaultValue = "0") String pageNo) {

		// 나중에 세션 ID 수정하기
		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerCustomDao.getNo(seller_id);

		PagingVO result= sellerCustomService.customReqPaging(pageNo, seller_no);
		
		model.addAttribute("paging", result);
		
		// 알람 check N count 개수
		model.addAttribute("customAlarm", sellerCustomDao.customAlarm(seller_no));

		// 1:1 받은 요청서
		List<CustomOrderVO> list = sellerCustomDao.getListReq(result);
		model.addAttribute("getListReq", list);
	
		return "seller/customListReq";
	}
	@GetMapping("/customInfoReq") // 받은 요청서 상세
	public String memberCustomContent(int member_custom_order_no, 
																		HttpSession session, Model model) {

		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerCustomDao.getNo(seller_id);
		
		// 판매자 알람 업데이트 후
		sellerCustomDao.updateAlarm(seller_no, member_custom_order_no);
		// 상세페이지 보기
		CustomOrderVO content = sellerCustomDao.customOrderVO1(member_custom_order_no, seller_no);

		model.addAttribute("getListInfoReq", content);
				// 카테고리 표시를 위한 model정보
		int category_no = content.getCustom_order_category();
		model.addAttribute("category", categoryDao.get(category_no));

		// 파일 번호 보내기
		List<FilesVO>  filesVO = memberCustomService.filesList(member_custom_order_no);
		model.addAttribute("filesVO", filesVO);
		
		return "seller/customInfoReq";
	}

	@GetMapping("/customListResp") // 보낸 견적서 목록
	public String getListCustomMine(Model model, HttpSession session,
														@RequestParam(value="pageNo", required=false, defaultValue = "0") String pageNo) {

		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerCustomDao.getNo(seller_id);
		
		
		PagingVO result= sellerCustomService.customRespPaging(pageNo, seller_no);
		
		model.addAttribute("paging", result);

		// 알람 check N count 개수
		model.addAttribute("customAlarm", sellerCustomDao.customAlarm(seller_no));

		// 내가 보낸 견적서		
		List<CustomOrderDto> list = sellerCustomDao.getListResp(result);
		model.addAttribute("getListResp", list);
	
		return "seller/customListResp";
	}	

	@GetMapping("/customInfoResp") // 보낸 견적서 상세
	public String CustomMineInfo(int seller_custom_order_no, Model model) {
		
		CustomOrderVO content = sellerCustomDao.customOrderVO2(seller_custom_order_no);
		model.addAttribute("getListInfoResp", content);
		
		// 파일번호 보내기
		List<FilesVO> filesVO = sellerCustomService.filesList(seller_custom_order_no);
		model.addAttribute("filesVO", filesVO);
		
		MemberCustomAlarmDto memberAlarm = memberCustomDao.getMemberAlarm(seller_custom_order_no);
		model.addAttribute("alarm", memberAlarm);
		
		int member_no = memberAlarm.getMember_no();
		MemberDto memberDto = memberDao.getMember(member_no);
		String member_id = memberDto.getMember_id();
		model.addAttribute("member_id", member_id);
		
		return "seller/customInfoResp";
	}

//	수정
	@PostMapping("/updateResp")
	public String updateCustom(CustomOrderVO customOrderVO) {
		int seller_custom_order_no = customOrderVO.getSeller_custom_order_no();
		int custom_order_no = sellerCustomDao.getCustomNo(seller_custom_order_no);
		
		CustomOrderDto customOrderDto
				= CustomOrderDto.builder()
												.custom_order_no(custom_order_no)
												.custom_order_title(customOrderVO.getCustom_order_title())
												.custom_order_content(customOrderVO.getCustom_order_content())
												.custom_order_price(customOrderVO.getCustom_order_price())
												.custom_order_hopedate(customOrderVO.getCustom_order_hopedate())
												.build();
		sellerCustomDao.updateCustom(customOrderDto);
		
		return "redirect:/seller/customInfoResp?seller_custom_order_no="+seller_custom_order_no;
	}
	
//	삭제
	@GetMapping("/deleteReq") // 받은 요청서 삭제
	public String CustomReqDelete(int member_custom_order_no,
																HttpSession session, Model model) {
		String seller_id = (String)session.getAttribute("seller_id");
		int seller_no = sellerCustomDao.getNo(seller_id); 
		
		model.addAttribute("seller_no", seller_no);
		
		// 판매자 알람 delete 컬럼 Y로 업데이트 --> 추후 구매자도 요청서를 삭제할 수 있도록
		sellerCustomDao.updateAlarm(seller_no, member_custom_order_no);
		
		// 알람테이블 삭제
		sellerCustomDao.deleteCustomReq(seller_no, member_custom_order_no);
		return "seller/customListReq";
	}
	@GetMapping("/deleteResp")	 // 보낸 견적서 삭제
	public String CustomDeleteResp(int seller_custom_order_no) {
		// seller_custom_order_no를 이용하여 custom_order_no를 가져오자
		int custom_order_no = sellerCustomDao.getCustomNo(seller_custom_order_no);
		// 해당 주문제작 테이블 데이터 삭제
		sellerCustomDao.deleteCustomResp(custom_order_no);
		// 구매자 알람테이블 정보 삭제
		sellerCustomDao.deleteAlarm(seller_custom_order_no);
		return "seller/customListResp";
	}

//	파일 이미지 다운로드
	@GetMapping("/download")
	public ResponseEntity<ByteArrayResource> CustomReqFile(@RequestParam int files_no) throws IOException{
		
		// 파일 no로 파일 정보 가져오기
		FilesDto filesDto = filesDao.getFiles(files_no);
		
		// 파일 이름 가져오기
		byte[] data = filesPhysicalDao.get(files_no); 
		if(data==null) {
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
