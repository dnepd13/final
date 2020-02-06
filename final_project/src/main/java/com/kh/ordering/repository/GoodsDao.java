package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.vo.GoodsVO;

public interface GoodsDao {
	void insert(GoodsVO goodsVO);
	void delete(int goods_no);
	GoodsDto get(int goods_no);
	List<GoodsDto> getList();
	int getSequence();
	GoodsVO getGoodsVO(int goods_no);
}
