package com.kh.ordering.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;
/*차단된 판매자와회원이 로그인 했을때 속행 하게 하겠다=return true*/
@Slf4j
public class BlockInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
    		throws Exception {
    log.info("preHandle 실행");	
    	return true;
    	
    }
	
	
	


}
