package com.kh.ordering.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
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

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.CartOkDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.FilesPhysicalDao;
import com.kh.ordering.repository.GoodsReviewDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.OrderDao;
import com.kh.ordering.service.CartInfoService;
import com.kh.ordering.service.GoodsReviewService;
import com.kh.ordering.vo.CartDetailsVO;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class GoodsCartReviewController {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private CartInfoService cartInfoService;
	@Autowired
	private GoodsReviewService goodsReviewService;
	@Autowired
	private GoodsReviewDao goodsReviewDao;
	
	@Autowired
	private FilesDao filesDao;
	@Autowired
	private FilesPhysicalDao filesPhysicalDao;
	
	@GetMapping("/cartList")
	public String orderingList(HttpSession session, Model model,
													@RequestParam(value = "pageNo", required=false, defaultValue = "0") String pageNo){
		
		// 전체 주문내역 cart_info 정보 넘기기
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);
		
		PagingVO result = cartInfoService.cartInfoPaging(pageNo, member_no);
		model.addAttribute("paging", result);
		List<CartInfoDto> getCartInfoMember = orderDao.getCartInfoMember(result);
		model.addAttribute("getCartInfo", getCartInfoMember);

		return "member/cartList";
	}
	@GetMapping("/cartDetailPay") // 상세 결제정보
	public String cartPayInfo(Model model,
													@RequestParam int partner_order_id) {
		
		
		return "member/cartDetailPay";
	}
	
	@GetMapping("/cartDetailGoods") // 상세 상품, 옵션정보
	public String cartInfoGoods(Model model,
													@RequestParam int cart_info_no) {

		List<CartDetailsVO> getCartGoods = orderDao.getCartGoods(cart_info_no);
		model.addAttribute("getCartGoods", getCartGoods);

		List<CartDetailsVO> optionList = new ArrayList<>();
		for(CartDetailsVO list : getCartGoods) {
			optionList.addAll(orderDao.getCartOption(list.getCart_info_goods_no())) ;
			
			model.addAttribute("getCartOption", optionList);
		}
		
		return "member/cartDetailGoods";
	}
	
//	구매확정, 리뷰등록 등 상태변화 update
	@PostMapping("/updateConfirm")
	@ResponseBody
	public CartOkDto updateConfirm(@RequestParam(value = "cart_info_goods_no") int cart_info_goods_no) {
		orderDao.updateCartOk(cart_info_goods_no);
		return orderDao.getCartOk(cart_info_goods_no);
	}
	
	@PostMapping("/insertReview")
	public String insertReview(HttpSession session, FilesVO files,
													@RequestParam int cart_info_no,
													@RequestParam int cart_info_goods_no,
													@ModelAttribute GoodsReviewDto goodsReviewDto)
													throws IllegalStateException, IOException {
		
		goodsReviewService.insertReview(session, files, cart_info_goods_no, goodsReviewDto);
		
		
		return "redirect:/member/cartDetails?cart_info_no="+cart_info_no;
	}

	// 파일 이미지 다운로드
		@GetMapping("/reviewFile")
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
