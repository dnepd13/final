package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.PortfolioDto;

import lombok.extern.slf4j.Slf4j;
@Repository
@Slf4j
public class PortfolioDaoImpl implements PortfolioDao {
	@Autowired
	 SqlSession sqlSession;
	@Override
	public void Portfolio_insert(PortfolioDto portfolioDto) {
	sqlSession.insert("portfolio.insert",portfolioDto);
		
	}

}