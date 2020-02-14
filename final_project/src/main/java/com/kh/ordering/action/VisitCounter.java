package com.kh.ordering.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.ordering.repository.VisitCountDao;
import com.kh.ordering.vo.VisitCountVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class VisitCounter extends HandlerInterceptorAdapter{
	private int userCount;
	
	@Autowired
	private VisitCountDao VisitCountDao;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
//		log.info("usercount={}", userCount);
//		log.info("생성된 SESSIONID %s \n={}",  session.getId());
//		log.info("session={}", session.getId());
		
//		알아야 할 정보
//		1. 모든요청 횟수
//		2. 신규세션 생성 횟수
		log.info("신규세션? {}", session.isNew());
		if(session.isNew()) {
			VisitCountDao.insertVisitor();
		}
		
//		3. Referer(어느 페이지에서 들어왔는가 : 직접 주소를 친 경우는 배제)
		log.info("Referer = {}", request.getHeader("Referer"));
		
//		VisitCountVO vo = VisitCountVO.builder().connecting(1).build();
//		log.info("vo={}", vo);
//		VisitCountDao.insertVisitor(vo);
		return true;
	}
}
