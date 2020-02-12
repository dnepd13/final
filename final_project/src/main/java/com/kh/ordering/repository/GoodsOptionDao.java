package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.vo.GoodsOptionVO;

public interface GoodsOptionDao {
	void insert(GoodsOptionDto goodsOptionDto);
	void delete(int goods_option_no);
	GoodsOptionDto get(int goods_option_no);
	List<GoodsOptionDto> getList();
	List<GoodsOptionDto> getList(int goods_no);
	int getSequence();
	List<GoodsOptionVO> getGoodsOptionVOList(int goods_no);
	List<GoodsOptionDto> getList(List<Integer> list);
}
