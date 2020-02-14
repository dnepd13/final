package com.kh.ordering.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.GoodsOptionDao;
import com.kh.ordering.vo.GoodsOptionVO;
import com.kh.ordering.vo.GoodsVO;

public class GoodsService {
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	
	public int insert(GoodsVO goodsVO) {
		goodsDao.insert(goodsVO);
		return goodsDao.getSequence();
	}
	
	public void delete(int goods_no) {
		goodsDao.delete(goods_no);
	}
	
	public GoodsDto get(int goods_no) {
		return goodsDao.get(goods_no);
	}
	
	public List<GoodsDto> getList() {
		return goodsDao.getList();
	}

	public GoodsVO getGoodsVO(int goods_no) {
		return goodsDao.getGoodsVO(goods_no);
	}

	public List<GoodsOptionVO> getGoodsOptionVOList(int goods_no) {
		return goodsOptionDao.getGoodsOptionVOList(goods_no);
	}
}
