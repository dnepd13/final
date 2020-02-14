package com.kh.ordering.service;

import java.net.URISyntaxException;

import com.kh.ordering.vo.PayReadyReturnVO;
import com.kh.ordering.vo.PayReadyVO;


public interface payService {
	PayReadyReturnVO ready(PayReadyVO vo) throws URISyntaxException;
}
