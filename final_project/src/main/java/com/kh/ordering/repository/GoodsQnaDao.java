package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.GoodsQnaDto;
import com.kh.ordering.vo.PagingVO;

public interface GoodsQnaDao {
	int getSeller(int goods_no); // 상품에서 seller_no 가져오기
	void insertQ(GoodsQnaDto goodsQnaDto);
	List<GoodsQnaDto> getQna(PagingVO pagingVO); // Qna 목록
	void insertA(GoodsQnaDto goodsQnaDto);
	int goodsQnaCount(int goods_no);
}
