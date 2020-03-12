package com.kh.ordering.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

@Service("memberLoginFilter")
public class MemberLoginFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		String login = (String) req.getSession().getAttribute("member_id");
		
		if(login!=null) {
			chain.doFilter(request, response);
		}
		else {
			resp = (HttpServletResponse) response;
			resp.sendRedirect(req.getContextPath()+"/member/login");
		}
	}

}
