package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.GoodsDto;

public interface GoodsDao {
	void insert(GoodsDto goodsDto);
	void delete(int goods_no);
	GoodsDto get(int goods_no);
	List<GoodsDto> getList();
	int getSequenct();
}
