package com.kh.admin.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service("adminMasterFilter")
@Slf4j
public class AdminMasterFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		String grade = (String) req.getSession().getAttribute("admin_grade");
		log.info("drade={}",grade);
		if(grade.equals("총괄관리자")) {
			chain.doFilter(request, response);
		}
		else {
			resp.sendError(403);
		}
	}

}
