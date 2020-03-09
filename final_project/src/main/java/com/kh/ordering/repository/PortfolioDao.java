package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.PortfolioDto;
import com.kh.ordering.vo.FilesVO;

public interface PortfolioDao {

	void Portfolio_insert(PortfolioDto portfolioDto);

	List<FilesVO> getFilesList(int seller_no); // 포트폴리오 FilesVO
}
