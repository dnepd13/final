package com.kh.ordering.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.repository.GoodsOptionDao;

public class GoodsOptionService {
	
	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	public void insert(GoodsOptionDto goodsOptionDto) {
		goodsOptionDao.insert(goodsOptionDto);
	}
	
	public void delete(int goods_option_no) {
		goodsOptionDao.delete(goods_option_no);
	}
	
	public GoodsOptionDto get(int goods_option_no) {
		return goodsOptionDao.get(goods_option_no);
	}
	
	public List<GoodsOptionDto> getList() {
		return goodsOptionDao.getList();
	}
}
