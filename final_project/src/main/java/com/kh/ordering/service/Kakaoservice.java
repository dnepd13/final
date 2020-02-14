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
import com.kh.ordering.vo.PayReadyReturnVO;
import com.kh.ordering.vo.PayReadyVO;

@Service
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
															.path("/pay/kakao")
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

}
