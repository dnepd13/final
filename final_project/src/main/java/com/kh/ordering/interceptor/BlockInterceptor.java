package com.kh.ordering.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.method.HandlerMethod;import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.ordering.controller.RegueiredAuth;
import com.kh.ordering.entity.BlockDto;

import lombok.extern.slf4j.Slf4j;
/*차단된 판매자와회원이 로그인 했을때 속행 하게 하겠다=return true*/
@Slf4j
@Service
public class BlockInterceptor extends HandlerInterceptorAdapter {
//    @Autowired
//    private SqlSession sqlSession;
//    @Autowired
//	private  BlockDto blockDto;
//	@Override
//    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//    		throws Exception {
//		String seller_id = (String) request.getAttribute("seller_id");
//		String member_id = (String) request.getAttribute("member_id");
//		int count;
//		if(seller_id!=null) {
//			count = sqlSession.selectOne("block.seller",seller_id);
//		}else
//			count = sqlSession.selectOne("block.member",member_id);
//    	if(count==0){
//    	//아이디를 이용해서 이 사람의 차단여부 알아낸다음 차단이면 에러페이지로 강제 이동,아니면 통과 return true
//    	
//	System.out.println("들어왔습니다");
//	
//			return true;
//		}
//	
//	else{
//		System.out.println("에러페이지입니다");
//		return false;
//
//		}
//	}


	
	
}
