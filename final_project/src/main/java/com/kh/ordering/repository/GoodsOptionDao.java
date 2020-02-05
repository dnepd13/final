package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.GoodsOptionDto;

public interface GoodsOptionDao {
	void insert(GoodsOptionDto goodsOptionDto);
	void delete(int goods_option_no);
	GoodsOptionDto get(int goods_option_no);
	List<GoodsOptionDto> getList();
	int getSequence();
}
