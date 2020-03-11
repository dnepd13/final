package com.kh.ordering.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ordering.entity.BlockDto;
import com.kh.ordering.repository.SellerBlockDao;

@Service("sellerBlockFilter")
public class SellerBlockFilter implements Filter{
	
	@Autowired
	private SellerBlockDao sellerBlockDao;
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
			
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		String seller = (String)req.getSession().getAttribute("seller_id");
		BlockDto block = sellerBlockDao.sellerBlock(seller);
		
		if(seller != null) {
			resp.sendError(403);
		}
		else {
			chain.doFilter(request, response);
		}
	}

}
