package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.vo.GoodsFileVO;
import com.kh.ordering.vo.GoodsVO;

public interface GoodsDao {
	void insert(GoodsVO goodsVO);
	void delete(int goods_no);
	GoodsDto get(int goods_no);
	List<GoodsDto> getList();
	int getSequence();
	GoodsVO getGoodsVO(int goods_no);
	int getStock(int goods_no);
	boolean minusStock(int goods_no, int stock);
	void plusStock(int goods_no, int stock);
	List<GoodsVO> getGoodsVOList(int seller_no);
	List<Integer> getGoodsNoList(int seller_no);
	int getGoodsMainImage(int goods_no);
	List<Integer> getContentImage(int goods_no);
	//정렬 나중에..
//	void getList(String type);
	List<GoodsFileVO> getListNew();
	List<GoodsFileVO> getListBest();
	List<GoodsDto> search(String keyword);
}
