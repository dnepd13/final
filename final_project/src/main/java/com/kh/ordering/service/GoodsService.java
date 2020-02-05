package com.kh.ordering.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.repository.GoodsDao;

public class GoodsService {
	
	@Autowired
	private GoodsDao goodsDao;
	
	public int insert(GoodsDto goodsDto) {
		goodsDao.insert(goodsDto);
		return goodsDao.getSequenct();
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
}
