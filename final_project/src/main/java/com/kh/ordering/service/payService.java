package com.kh.ordering.service;

import java.net.URISyntaxException;

import com.kh.ordering.vo.KakaoPayRevokeReturnVO;
import com.kh.ordering.vo.KakaoPaySuccessReadyVO;
import com.kh.ordering.vo.KakaoPaySuccessReturnVO;
import com.kh.ordering.vo.PayReadyReturnVO;
import com.kh.ordering.vo.PayReadyVO;


public interface payService {
	PayReadyReturnVO ready(PayReadyVO vo) throws URISyntaxException;
	KakaoPaySuccessReturnVO approve(KakaoPaySuccessReadyVO data) throws URISyntaxException;
	KakaoPayRevokeReturnVO revoke(int no)  throws URISyntaxException;
}
