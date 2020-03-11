//package com.kh.ordering.interceptor;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.apache.ibatis.session.SqlSession;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.method.HandlerMethod;
//import org.springframework.web.method.support.HandlerMethodArgumentResolver;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//
//import com.kh.ordering.entity.BlockDto;
//
//import lombok.extern.slf4j.Slf4j;
//
///*차단된 판매자와회원이 로그인 했을때 속행 하게 하겠다=return true*/
//@Slf4j
//@Service
//public class BlockmemberInterceptor extends HandlerInterceptorAdapter {
//	@Autowired
//	private SqlSession sqlSession;
//	@Autowired
//	private BlockDto blockDto;
//
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
// String member_id = (String) request.getAttribute("member_id");
//		int count;
//		if (member_id != null) {//일반회원이 로그인을 하면
//			count = sqlSession.selectOne("block.member", member_id);
//			if(count==1) {//차단된 회원이라면 
//				//차단되었다는 페이지로 보내준다
//				response.sendRedirect(request.getContextPath()+"/block/user");
//				return false;//여기도 차단
//			}
//			else {
//				//차단되지 않은 멤버라면 통과
//				return true;
//			}
//		} else {//회원이 아니라면 
//		//회원 로그인 페이지로
//			response.sendRedirect(request.getContextPath()+"/member/login");
//			return false;
//		}
//		
//		
//	}
//
//}
