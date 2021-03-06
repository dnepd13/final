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
import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartOkDto;
import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.entity.GoodsReviewReplyDto;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.FilesPhysicalDao;
import com.kh.ordering.repository.GoodsReviewDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.OrderDao;
import com.kh.ordering.service.CartInfoService;
import com.kh.ordering.service.GoodsReviewService;
import com.kh.ordering.vo.CartDetailsVO;
import com.kh.ordering.vo.CartInfoVO;
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
													@RequestParam String partner_order_id) {
		
		List<CartInfoVO> payDetails = orderDao.getCartPay(partner_order_id);

		model.addAttribute("payDetails", payDetails.get(0));
		
		// 상품 1에 대해 구매확정 시 취소 불가
		int count = 0;
		List<CartInfoGoodsDto> list = new ArrayList<>();
		List<CartOkDto> cartOk = new ArrayList<>();
		for(int i=0 ; i<payDetails.size() ; i++) {
			list.addAll(orderDao.getCartInfoGoods(payDetails.get(i).getCart_info_no()));
			
			for(int k =0 ; k<list.size() ; k++) {
				cartOk.add(k, orderDao.getCartOk(list.get(i).getCart_info_goods_no()));
				String status= cartOk.get(k).getCart_ok_status();
				if(status !=null) {
					count ++;
				}
			}
		}
		model.addAttribute("okCount", count);
		
		return "member/cartDetailPay";
	}
	
	@GetMapping("/cartDetailCustom")
	public String cartInfoCustom(Model model, int cart_info_no) {
		// partner_order_id에서 custom_no를 구하고
		CartInfoDto cartInfoDto = orderDao.getCartInfoDto(cart_info_no);
		// member_custom_order_no를 구해서
		String partner_order_id=cartInfoDto.getPartner_order_id();
		int custom_order_no = Integer.parseInt(partner_order_id.substring(partner_order_id.lastIndexOf("C")+1));
		CustomOrderDto customOrder = orderDao.getCustomOrderDto(custom_order_no);

		// 페이지로 넘기기
		model.addAttribute("customOrder", customOrder);
		return "member/cartDetailCustom";
	}
	@GetMapping("/cartDetailGoods") // 상세 상품, 옵션정보
	public String cartInfoGoods(Model model,
													@RequestParam int cart_info_no) {
		
		List<CartDetailsVO> getCartGoods = orderDao.getCartGoods(cart_info_no);

		if(getCartGoods.size()==0) {

			return "redirect:/member/cartDetailCustom?cart_info_no="+cart_info_no;
		}
		else {
			model.addAttribute("getCartGoods", getCartGoods);

			List<CartDetailsVO> optionList = new ArrayList<>();
			for(CartDetailsVO list : getCartGoods) {
				optionList.addAll(orderDao.getCartOption(list.getCart_info_goods_no())) ;
				
				model.addAttribute("getCartOption", optionList);
			}
			
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
		
		
		return "redirect:/member/cartDetailGoods?cart_info_no="+cart_info_no;
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
		@PostMapping("/updateReply")
		public String updateReply(@ModelAttribute GoodsReviewReplyDto goodsReviewReplyDto,
														int goods_review_reply_no) {
			
			int member_no = goodsReviewReplyDto.getMember_no();
			
			goodsReviewReplyDto.setMember_no(member_no);
			goodsReviewReplyDto.setGoods_review_no(goodsReviewReplyDto.getGoods_review_no());
			goodsReviewReplyDto.setGoods_review_reply_content(goodsReviewReplyDto.getGoods_review_reply_content());
			goodsReviewDao.updateReviewReply(goodsReviewReplyDto);
			
			int goods_no = goodsReviewDao.getGoodsNoReview(goodsReviewReplyDto.getGoods_review_no());
			
			return "redirect:/goods/goodsInfo?goods_no="+goods_no;
		}
		@PostMapping("/deleteReply")
		public String deleteReply(@RequestParam int goods_review_reply_no,
														@RequestParam int goods_review_no) {
			goodsReviewDao.deleteReviewReply(goods_review_reply_no);
			
			int goods_no = goodsReviewDao.getGoodsNoReview(goods_review_no);
			
			return "redirect:/goods/goodsInfo?goods_no="+goods_no;
		}
}
