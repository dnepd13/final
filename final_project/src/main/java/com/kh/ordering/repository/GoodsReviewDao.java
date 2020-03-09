package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.entity.GoodsReviewFilesDto;
import com.kh.ordering.entity.GoodsReviewReplyDto;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

public interface GoodsReviewDao {
	int getNoCurr(); // 리뷰테이블 현재 시퀀스번호
	int filesSeq(); // 파일 다음 시퀀스번호
	
	void insertReview(GoodsReviewDto goodsReviewDto);
	int getGoodsNo(int cart_info_goods_no);
	
	void reviewFilesInsert(GoodsReviewFilesDto goodsReviewFilesDto); // 리뷰 파일 등록
	List<GoodsReviewDto> getReview(PagingVO pagingVO); // 리뷰 목록
	int getCount(int goods_no);
	int getStarAvg(int goods_no); // 상품 리뷰 평점
	
	// 파일 출력용
	List<FilesVO> getFilesNo(int goods_review_no); // 리뷰의 파일 No 가져오기
	
	// 리뷰 댓글
	int getGoodsNoReview(int goods_review_no); // 리뷰번호로 상품번호 가져오기(리다이렉트 용)
	void insertReviewReply(GoodsReviewReplyDto goodsReviewReplyDto);
	List<GoodsReviewReplyDto> getListReply(int goods_review_no);
}
