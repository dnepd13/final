package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.entity.GoodsReviewFilesDto;
import com.kh.ordering.vo.FilesVO;

public interface GoodsReviewDao {
	int getNoCurr(); // 리뷰테이블 현재 시퀀스번호
	int filesSeq(); // 파일 다음 시퀀스번호
	
	void insertReview(GoodsReviewDto goodsReviewDto);
	int getOrderingNo(int cart_info_no); // ordering 번호
	int getGoodsNo(int cart_info_no);
	
	void reviewFilesInsert(GoodsReviewFilesDto goodsReviewFilesDto); // 리뷰 파일 등록
	List<GoodsReviewDto> getReview(int goods_no);
	// 파일 출력용
	List<FilesVO> getFilesNo(int goods_review_no); // 요청서의 파일 No 가져오기
}
