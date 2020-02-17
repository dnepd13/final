package com.kh.ordering.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.ordering.entity.PayDto;
import com.kh.ordering.repository.PayDao;
import com.kh.ordering.vo.KakaoPayReadyReturnVO;
import com.kh.ordering.vo.KakaoPayRevokeReturnVO;
import com.kh.ordering.vo.KakaoPaySuccessReadyVO;
import com.kh.ordering.vo.KakaoPaySuccessReturnVO;
import com.kh.ordering.vo.PayReadyReturnVO;
import com.kh.ordering.vo.PayReadyVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class Kakaoservice implements payService {
	
	@Autowired
	private PayDao payDao;
	
	@Override
	public PayReadyReturnVO ready(PayReadyVO vo) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK df1490a82355dcdc6183933334d252ee");
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+"; charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("partner_order_id", vo.getPartner_order_id());
		body.add("partner_user_id", vo.getPartner_user_id());
		body.add("item_name", vo.getItem_name());
		body.add("quantity", String.valueOf(vo.getQuantity())); //인트로 안됨
		body.add("total_amount", String.valueOf(vo.getTotal_amount()));
		body.add("vat_amount", String.valueOf(vo.getVat_amount()));
		body.add("tax_free_amount", String.valueOf(vo.getTax_free_amount()));
		
		String baseUrl = ServletUriComponentsBuilder
															.fromCurrentContextPath()
															.port(8080)
															.path("/pay/kakao/")
															.toUriString();
		
		body.add("approval_url", baseUrl+"success");
		body.add("fail_url", baseUrl+"fail");
		body.add("cancel_url", baseUrl+"cancel");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		KakaoPayReadyReturnVO returnVO = 
				template.postForObject(uri, entity, KakaoPayReadyReturnVO.class);
		
		PayDto payDto = PayDto.builder()
										.cid("TC0ONETIME")
										.tid(returnVO.getTid())
										.partner_order_id(vo.getPartner_order_id())
										.partner_user_id(vo.getPartner_user_id())
										.item_name(vo.getItem_name())
										.process_time(returnVO.getCreated_at())
										.quantity(vo.getQuantity())
										.total_amount(vo.getTotal_amount())
										.build();
								
		payDao.insertReady(payDto);
		return returnVO;
	}

	@Override
	public KakaoPaySuccessReturnVO approve(KakaoPaySuccessReadyVO data) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK df1490a82355dcdc6183933334d252ee");
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+"; charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", data.getCid());//가맹점번호(개발자용 테스트값)
		body.add("tid", data.getTid());
		body.add("partner_order_id", data.getPartner_order_id());
		body.add("partner_user_id", data.getPartner_user_id());
		body.add("pg_token", data.getPg_token());
		log.info("cid={}", data.getCid());
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");
		
		log.info("1번");
		log.info("uri={}", uri);
		log.info("entity={}",entity);
		KakaoPaySuccessReturnVO returnVO = template.postForObject(uri, entity, KakaoPaySuccessReturnVO.class);
		
		log.info("2번");
		PayDto payDto = PayDto.builder()
													.cid(returnVO.getCid())
													.tid(returnVO.getTid())
													.process_time(returnVO.getCreated_at())
													.item_name(returnVO.getItem_name())
													.partner_order_id(returnVO.getPartner_order_id())
													.partner_user_id(returnVO.getPartner_user_id())
													.quantity(returnVO.getQuantity())
													.total_amount(returnVO.getAmount().getTotal())
													.aid(returnVO.getAid())
													.build();
		
		payDao.insertSuccess(payDto);
		//이곳에 다른 정보들도 저장되어야한다
		//저장되어야할 것들 
		//상품정보 개별(정보, 옵션, 상품+옵션 가격 및 수량, 상품 배송정보
		
		return returnVO;
	}

	//취소
	@Override
	public KakaoPayRevokeReturnVO revoke(int no)  throws URISyntaxException {
		PayDto payDto = payDao.get(no);
		
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK df1490a82355dcdc6183933334d252ee");
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+"; charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", payDto.getCid());
		body.add("tid", payDto.getTid());
		body.add("cancel_amount", String.valueOf(payDto.getTotal_amount()));
		body.add("cancel_tax_free_amount", "0");
		body.add("cancel_available_amount", String.valueOf(payDto.getTotal_amount()));
		
		HttpEntity<MultiValueMap<String, String>> entity =
				new HttpEntity<>(body, headers);
		log.info("entity={}",entity);
		URI uri = new URI("https://kapi.kakao.com/v1/payment/cancel");
		log.info("uri={}",uri);
		
		KakaoPayRevokeReturnVO returnVO=
				template.postForObject(uri, entity, KakaoPayRevokeReturnVO.class);
		log.info("returnVO={}",returnVO);
		
		PayDto payDto2 = PayDto.builder()
										.aid(returnVO.getAid())
										.tid(returnVO.getTid())
										.cid(returnVO.getCid())
										.partner_order_id(returnVO.getPartner_order_id())
										.partner_user_id(returnVO.getPartner_user_id())
										.process_time(returnVO.getCanceled_at())
										.item_name(returnVO.getItem_name())
										.quantity(returnVO.getQuantity())
										.total_amount(-1*returnVO.getCanceled_amount().getTotal())
									.build();
		
		payDao.insertRevoke(payDto2);
		return null;
	}

}
