package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.PortfolioDto;
import com.kh.ordering.vo.FilesVO;

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
	@Override // 파일 이미지 출력. Model로 보낼 List
	public List<FilesVO> getFilesList(int seller_no) {
		return sqlSession.selectList("portfolio.getFilesNo", seller_no);
	}
	@Override
	public void portfolio_delete(PortfolioDto portfolioDto) {
		sqlSession.delete("portfolio.deleteFiles", portfolioDto);
	}

}
