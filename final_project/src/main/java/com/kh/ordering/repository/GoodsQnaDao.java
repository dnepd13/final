package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.GoodsQnaDto;
import com.kh.ordering.vo.PagingVO;

public interface GoodsQnaDao {
	int getSeller(int goods_no); // 상품에서 seller_no 가져오기
	GoodsQnaDto getQna(int goods_qna_no); // qna_no 단일조회
	
	void insertQ(GoodsQnaDto goodsQnaDto); // 구매자 문의 작성
	void updateQ(GoodsQnaDto goodsQnaDto); // 구매자 문의 수정
	void deleteQ(GoodsQnaDto goodsQnaDto); // 구매자 문의 삭제
	
	List<GoodsQnaDto> getListQna(PagingVO pagingVO); // Qna 목록
	void insertA(GoodsQnaDto goodsQnaDto);
	int goodsQnaCount(int goods_no);
	
	// 답변이 달렸는지 아닌지 확인
	void getIsQna(int goods_qna_groupno);

}
