package com.kh.ordering.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.ordering.entity.BlockDto;

import lombok.extern.slf4j.Slf4j;

/*차단된 판매자와회원이 로그인 했을때 속행 하게 하겠다=return true*/
@Slf4j
@Service
public class BlockSellerInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private BlockDto blockDto;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String block_id = (String) request.getSession().getAttribute("seller_id");
		log.info("session={}",block_id);
		// String member_id = (String) request.getAttribute("member_id");
		int count=0;
		log.info(block_id);
		log.info("count={}", count);
		if (block_id != null) {//판매자가 로그인을 하면
			count = sqlSession.selectOne("Block.seller", block_id);
			log.info("countttt={}", count);
			if(count==1) {//차단된 판매자라면                                                                                                                  
				//차단되었다는 페이지로 보내준다
				response.sendRedirect(request.getContextPath()+"/block/user");
				log.info("count1={}", count);
				return false;//여기도 차단
			}
			else {
				//차단되지 않은 판매자라면 통과
				log.info("count2={}", count);
				return true;
			}
		} else {//판매자가 아니라면//차단된 판매자라면 문의게시판 빼고 다 저 login.jsp 404페이지로뜬다 
		//판매자 로그인 페이지로
	//		response.sendRedirect(response.getContextPath()+"/seller/login");
			response.sendRedirect(request.getContextPath()+"/seller/login");
			return false;
		}
		
		
	}

}
