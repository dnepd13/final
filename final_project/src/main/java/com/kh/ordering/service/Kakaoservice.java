package com.kh.ordering.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartOkDto;
import com.kh.ordering.entity.Member_PointDto;
import com.kh.ordering.entity.PayDto;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.Member_PointDao;
import com.kh.ordering.repository.OrderDao;
import com.kh.ordering.repository.PayDao;
import com.kh.ordering.vo.KakaoPayReadyReturnVO;
import com.kh.ordering.vo.KakaoPayReadyVO;
import com.kh.ordering.vo.KakaoPayRevokeReturnVO;
import com.kh.ordering.vo.KakaoPaySuccessReadyVO;
import com.kh.ordering.vo.KakaoPaySuccessReturnVO;
import com.kh.ordering.vo.MemberPointVO;
import com.kh.ordering.vo.OrderVO;
import com.kh.ordering.vo.PayReadyReturnVO;
import com.kh.ordering.vo.PayReadyVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class Kakaoservice implements payService {

	@Autowired
	private MemberDao memberDao;
	@Autowired
	private Member_PointDao memberPointDao;
	@Autowired
	private MemberCustomDao memberCustomDao;

	@Autowired
	private PayDao payDao;

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private SqlSession sqlSession;

	@Override
	public PayReadyReturnVO ready(PayReadyVO vo, String jsonOrderVO, HttpSession session)
			throws URISyntaxException, JsonMappingException, JsonProcessingException {

		RestTemplate template = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK df1490a82355dcdc6183933334d252ee");
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + "; charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("partner_order_id", vo.getPartner_order_id()); // 주문번호 랜덤생성해야함
		body.add("partner_user_id", vo.getPartner_user_id());
		body.add("item_name", vo.getItem_name());
		body.add("quantity", String.valueOf(vo.getQuantity())); // 인트로 안됨
		body.add("total_amount", String.valueOf(vo.getTotal_amount()));
		body.add("vat_amount", String.valueOf(vo.getVat_amount()));
		body.add("tax_free_amount", String.valueOf(vo.getTax_free_amount()));

		String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().port(8080).path("/pay/kakao/")
				.toUriString();

		body.add("approval_url", baseUrl + "success");
		body.add("fail_url", baseUrl + "fail");
		body.add("cancel_url", baseUrl + "cancel");

		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);

		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");

		KakaoPayReadyReturnVO returnVO = template.postForObject(uri, entity, KakaoPayReadyReturnVO.class);

		int member_no = sqlSession.selectOne("member.getNo", session.getAttribute("member_id"));

		ObjectMapper mapper = new ObjectMapper();
		OrderVO orderVO = mapper.readValue(jsonOrderVO, OrderVO.class);

		PayDto payDto = PayDto.builder().cid("TC0ONETIME").tid(returnVO.getTid()).member(member_no)
				.partner_order_id(vo.getPartner_order_id()).partner_user_id(vo.getPartner_user_id())
				.item_name(vo.getItem_name()).process_time(returnVO.getCreated_at()).quantity(vo.getQuantity())
				.total_amount(vo.getTotal_amount()).used_point(orderVO.getUsed_point())
				.vat_amount(vo.getTotal_amount() / 10).build();

		payDao.insertReady(payDto, orderVO);

		return returnVO;
	}

	@Override
	public KakaoPaySuccessReturnVO approve(KakaoPaySuccessReadyVO data) throws URISyntaxException {
		RestTemplate template = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK df1490a82355dcdc6183933334d252ee");
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + "; charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", data.getCid());// 가맹점번호(개발자용 테스트값)
		body.add("tid", data.getTid());
		body.add("partner_order_id", data.getPartner_order_id());
		body.add("partner_user_id", data.getPartner_user_id());
		body.add("pg_token", data.getPg_token());
//		log.info("cid={}", data.getCid());
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);

		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");

//		log.info("1번");
//		log.info("uri={}", uri);
//		log.info("entity={}",entity);
		// 결제 완료 요청
		KakaoPaySuccessReturnVO returnVO = template.postForObject(uri, entity, KakaoPaySuccessReturnVO.class);

		int member_no = orderDao.getMember_no(returnVO.getPartner_order_id());
		
//		log.info("2번");
		PayDto payDto = PayDto.builder().cid(returnVO.getCid()).tid(returnVO.getTid()).member(member_no)
				.process_time(returnVO.getCreated_at()).item_name(returnVO.getItem_name())
				.partner_order_id(returnVO.getPartner_order_id()).partner_user_id(returnVO.getPartner_user_id())
				.quantity(returnVO.getQuantity()).total_amount(returnVO.getAmount().getTotal()).aid(returnVO.getAid())
				.used_point(returnVO.getAmount().getPoint()).vat_amount(returnVO.getAmount().getVat()).build();

		payDao.insertSuccess(payDto);

		// 구매확정 테이블에 추가
		int cart_info_no = orderDao.getCartInfoNo(returnVO.getPartner_order_id());
		List<CartInfoGoodsDto> cartInfoGoods  = orderDao.getCartInfoGoods(cart_info_no);
		for(int i=0 ; i<cartInfoGoods.size() ; i++) {
			
			int cart_info_goods_no = cartInfoGoods.get(i).getCart_info_goods_no();

			CartOkDto cartOkDto = CartOkDto.builder().cart_info_goods_no(cart_info_goods_no)
					.member_no(member_no).build();
			memberDao.insertCartOk(cartOkDto);
		}

		return returnVO;
	}

	// 수량,포인트 검사
	@Override
	public boolean transactionOrder(String partner_order_id) throws Exception {
		return orderDao.updatePointAndStock(partner_order_id);
	}

	// 취소
	@Override
	public KakaoPayRevokeReturnVO revoke(int ordering_no) throws URISyntaxException {
		PayDto payDto = payDao.get(ordering_no);

		RestTemplate template = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK df1490a82355dcdc6183933334d252ee");
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + "; charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", payDto.getCid());
		body.add("tid", payDto.getTid());
		body.add("cancel_amount", String.valueOf(payDto.getTotal_amount()));
		body.add("cancel_tax_free_amount", "0");
		body.add("cancel_available_amount", String.valueOf(payDto.getTotal_amount()));

		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		log.info("entity={}", entity);
		URI uri = new URI("https://kapi.kakao.com/v1/payment/cancel");
		log.info("uri={}", uri);

		KakaoPayRevokeReturnVO returnVO = template.postForObject(uri, entity, KakaoPayRevokeReturnVO.class);
		log.info("returnVO={}", returnVO);

		PayDto payDto2 = PayDto.builder().aid(returnVO.getAid()).tid(returnVO.getTid()).cid(returnVO.getCid()).member(orderDao.getMember_no(payDto.getPartner_order_id()))
				.partner_order_id(returnVO.getPartner_order_id()).partner_user_id(returnVO.getPartner_user_id())
				.process_time(returnVO.getCanceled_at()).item_name(returnVO.getItem_name())
				.quantity(returnVO.getQuantity()).total_amount(-1 * returnVO.getCanceled_amount().getTotal()).build();

		payDao.insertRevoke(payDto2);
		// 취소 되면 포인트 돌려주고,
		int used_point = orderDao.getCartInfo(payDto.getPartner_order_id()).getUsed_point();
		MemberPointVO memberPointVO = MemberPointVO.builder()
				.member_no(orderDao.getMember_no(payDto.getPartner_order_id())).member_point_change(used_point)
				.member_point_status("적립").member_point_content("결제 취소").build();

		memberDao.registPoint(memberPointVO);

		return null;
	}

	@Override
	public KakaoPayReadyVO setReadyVO(String jsonOrderVO) throws JsonMappingException, JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		OrderVO orderVO = mapper.readValue(jsonOrderVO, OrderVO.class);

		KakaoPayReadyVO kakaoPayReadyVO = KakaoPayReadyVO.builder().partner_order_id(payDao.getPartnerOrderId())
				.partner_user_id(orderVO.getPartner_user_id()).item_name(payDao.getItem_name(orderVO))
				.quantity(orderVO.getTotal_quantity()).total_amount(orderVO.getTotal_price())
				.vat_amount(orderVO.getTotal_price() / 10).tax_free_amount(0).build();

		return kakaoPayReadyVO;
	}

///////////////////// 주문제작
//	결제준비요청
	@Override // 결제준비 요청 데이터 set
	public KakaoPayReadyVO setCustomReadyVO(String jsonOrderVO) throws JsonMappingException, JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		OrderVO orderVO = mapper.readValue(jsonOrderVO, OrderVO.class);

		KakaoPayReadyVO kakaoPayReadyVO = KakaoPayReadyVO.builder()
				.partner_order_id(payDao.getPartnerOrderId()+"C" + orderVO.getCustomOrderVO().getCustom_order_no())
				.partner_user_id(orderVO.getPartner_user_id())
				.item_name(orderVO.getCustomOrderVO().getCustom_order_title()).quantity(orderVO.getTotal_quantity())
				.total_amount(orderVO.getTotal_price()).vat_amount(orderVO.getTotal_price() / 10).tax_free_amount(0)
				.build();

		return kakaoPayReadyVO;
	}

	@Override // 결제준비요청 전송, 응답
	public PayReadyReturnVO readyReturnVO(PayReadyVO readyVO, HttpSession session, String jsonOrderVO)
			throws URISyntaxException, JsonMappingException, JsonProcessingException {
		// 회원정보
		String member_id = (String) session.getAttribute("member_id");
		int member_no = sqlSession.selectOne("member.getNo", member_id);

		// PayReadyVO에서 요청할 데이터를 담은 카카오ReadyVO로 다운캐스팅
		KakaoPayReadyVO object = (KakaoPayReadyVO) readyVO;

		// 전송도구 = 헤더+바디
		RestTemplate template = new RestTemplate();

		// 헤더
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK 53072513ab4d31c036edec9ad0220095");
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE); // 카카오의 응답을 받을 형태

		// 바디
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("cid", "TC0ONETIME");
		body.add("partner_order_id", object.getPartner_order_id()); // 견적서 번호
		body.add("partner_user_id", member_id);
		body.add("item_name", object.getItem_name()); // 견적서 제목
		body.add("quantity", String.valueOf(object.getQuantity()));
		body.add("total_amount", String.valueOf(object.getTotal_amount())); // 견적가격
		body.add("tax_free_amount", String.valueOf(object.getTax_free_amount()));
		body.add("vat_amount", String.valueOf(object.getVat_amount()));
		body.add("approval_url", "http://localhost:8080/ordering/pay/kakao/customPaySuccess");
		body.add("cancel_url", "http://localhost:8080/ordering/pay/kakao/customPayCancel");
		body.add("fail_url", "http://localhost:8080/ordering/member/customInfoResp");

		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);

		// 요청주소
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		// 요청주소에 전송 및 회신 응답 저장
		// url, 요청객체, 응답객체(JSON)
		KakaoPayReadyReturnVO readyReturnVO = template.postForObject(uri, entity, KakaoPayReadyReturnVO.class);
		
		// DB에 결제준비 요청 정보 저장 --> PayDto
		ObjectMapper mapper = new ObjectMapper();
		OrderVO orderVO = mapper.readValue(jsonOrderVO, OrderVO.class);

		PayDto payDto = PayDto.builder()
													.cid("TC0ONETIME")
													.tid(readyReturnVO.getTid())
													.member(member_no)
													.partner_order_id(readyVO.getPartner_order_id())
													.partner_user_id(readyVO.getPartner_user_id())
													.item_name(readyVO.getItem_name())
													.process_time(readyReturnVO.getCreated_at())
													.quantity(readyVO.getQuantity())
													.total_amount(readyVO.getTotal_amount())
													.used_point(orderVO.getUsed_point())
													.vat_amount(readyVO.getTotal_amount() / 10).build();

		payDao.insertReadyCustom(payDto, orderVO);

		return readyReturnVO;
	}

	@Override // 요청 성공 후 결제승인
	public KakaoPaySuccessReturnVO approveVO(KakaoPaySuccessReadyVO successReadyVO, 
																						HttpSession session) throws URISyntaxException {

		// PayReadyVO에서 요청할 데이터를 담은 카카오ReadyVO로 다운캐스팅
//		 KakaoPayReadyVO object = (KaㄴkaoPayReadyVO) readyVO;

		// 전송도구 = 헤더+바디
		RestTemplate template = new RestTemplate();

		// 헤더
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK 53072513ab4d31c036edec9ad0220095");
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+"; charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE); // 카카오의 응답을 받을 형태

		// 바디
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("cid", successReadyVO.getCid());
		body.add("tid", successReadyVO.getTid());
		body.add("partner_order_id", successReadyVO.getPartner_order_id());
		body.add("partner_user_id", successReadyVO.getPartner_user_id());
		body.add("pg_token", successReadyVO.getPg_token());

		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);

		// 요청주소
		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");

		// 요청주소에 전송 및 회신 응답 저장
		// url, 요청객체, 응답객체
		KakaoPaySuccessReturnVO successReturnVO = template.postForObject(uri, entity, KakaoPaySuccessReturnVO.class);

		// 회원정보
		int member_no = orderDao.getMember_no(successReturnVO.getPartner_order_id());
		
		// DB 승인완료 내용 저장
		PayDto payDto = PayDto.builder().cid(successReturnVO.getCid()).tid(successReturnVO.getTid()).member(member_no)
				.process_time(successReturnVO.getCreated_at()).item_name(successReturnVO.getItem_name())
				.partner_order_id(successReturnVO.getPartner_order_id())
				.partner_user_id(successReturnVO.getPartner_user_id()).quantity(successReturnVO.getQuantity())
				.total_amount(successReturnVO.getAmount().getTotal()).aid(successReturnVO.getAid())
				.used_point(successReturnVO.getAmount().getPoint()).vat_amount(successReturnVO.getAmount().getVat())
				.build();
		payDao.insertSuccess(payDto);

		// 구매확정테이블 저장
		CartOkDto cartOkDto = CartOkDto.builder().cart_info_custom_no(successReadyVO.getPartner_order_id())
				.member_no(member_no).build();
		memberDao.insertCartOkCustom(cartOkDto);

		// 회원 포인트 차감내용 추가
		CartInfoDto cartInfoDto = payDao.getCartInfoDto(successReadyVO.getPartner_order_id());
		int used_point = cartInfoDto.getUsed_point();
		Member_PointDto memberPointDto = Member_PointDto.builder().member_no(member_no)
				.member_point_change(-1 * used_point).member_point_content("상품 구매에 사용").build();
		memberPointDao.usedPoint(memberPointDto);

		// 주문제작 상태 update
		// 문자열 잘라서 넣기
		String custom_order = successReadyVO.getPartner_order_id().substring(successReadyVO.getPartner_order_id().lastIndexOf("C")+1);
		int custom_order_no = Integer.parseInt(custom_order); 
		memberCustomDao.updateCustomPay(custom_order_no);
		
		// 구매에 따른 회원 포인트 적립
		memberDao.registOrderPoint(member_no, successReturnVO.getAmount().getTotal());

		return successReturnVO;

	}

	@Override // 주문제작 결제취소
	public KakaoPayRevokeReturnVO customRevokeVO(PayDto payDto) throws URISyntaxException {

		RestTemplate template = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK 53072513ab4d31c036edec9ad0220095");
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + "; charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", payDto.getCid());
		body.add("tid", payDto.getTid());
		body.add("cancel_amount", String.valueOf(payDto.getTotal_amount()));
		body.add("cancel_tax_free_amount", "0");
		body.add("cancel_available_amount", String.valueOf(payDto.getTotal_amount()));
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/cancel");
		
		KakaoPayRevokeReturnVO revokeReturnVO
										= template.postForObject(uri, entity, KakaoPayRevokeReturnVO.class);

		int member_no = orderDao.getMember_no(payDto.getPartner_order_id());
		
		PayDto payDto2 = PayDto.builder()
														.aid(revokeReturnVO.getAid())
														.tid(revokeReturnVO.getTid())
														.cid(revokeReturnVO.getCid())
														.member(member_no)
														.partner_order_id(revokeReturnVO.getPartner_order_id())
														.partner_user_id(revokeReturnVO.getPartner_user_id())
														.process_time(revokeReturnVO.getCanceled_at())
														.item_name(revokeReturnVO.getItem_name())
														.quantity(revokeReturnVO.getQuantity())
														.total_amount(-1 * revokeReturnVO.getCanceled_amount().getTotal())
														.build();
		payDao.insertRevoke(payDto2);
		
		// 포인트 취소
		int used_point = orderDao.getCartInfo(payDto.getPartner_order_id()).getUsed_point();
		MemberPointVO memberPointVO = MemberPointVO.builder()
				.member_no(orderDao.getMember_no(payDto.getPartner_order_id())).member_point_change(used_point)
				.member_point_status("적립").member_point_content("결제 취소").build();

		memberDao.registPoint(memberPointVO);
		
		// 주문제작 상태 update
		String custom_order = revokeReturnVO.getPartner_order_id().substring(revokeReturnVO.getPartner_order_id().lastIndexOf("C")+1);
		int custom_order_no = Integer.parseInt(custom_order); 
		memberCustomDao.updateCustomCancel(custom_order_no);
		
		return revokeReturnVO;
	}

}
