package com.kh.ordering.service;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.kh.ordering.vo.KakaoPayReadyVO;
import com.kh.ordering.vo.KakaoPayRevokeReturnVO;
import com.kh.ordering.vo.KakaoPaySuccessReadyVO;
import com.kh.ordering.vo.KakaoPaySuccessReturnVO;
import com.kh.ordering.vo.PayReadyReturnVO;
import com.kh.ordering.vo.PayReadyVO;


public interface payService {
	PayReadyReturnVO ready(PayReadyVO vo, String jsonOrderVO, HttpSession session) throws URISyntaxException, JsonMappingException, JsonProcessingException;
	KakaoPaySuccessReturnVO approve(KakaoPaySuccessReadyVO data) throws URISyntaxException;
	KakaoPayRevokeReturnVO revoke(int no)  throws URISyntaxException;
	KakaoPayReadyVO setReadyVO(String orerVO) throws JsonMappingException, JsonProcessingException;
}
