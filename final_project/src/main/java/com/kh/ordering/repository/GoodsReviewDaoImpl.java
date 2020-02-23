package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.entity.GoodsReviewFilesDto;
import com.kh.ordering.entity.GoodsReviewReplyDto;
import com.kh.ordering.vo.FilesVO;

@Repository
public class GoodsReviewDaoImpl implements GoodsReviewDao{
	@Autowired
	private SqlSession sqlSession;

	@Override // 리뷰테이블 현재 시퀀스번호
	public int getNoCurr() {
		return sqlSession.selectOne("review.getNoCurr");
	}
	@Override // 파일테이블 다음 시퀀스번호
	public int filesSeq() {
		return sqlSession.selectOne("files.getSeq");
	}
	
	@Override
	public void insertReview(GoodsReviewDto goodsReviewDto) {
		sqlSession.insert("review.insertReview", goodsReviewDto);
	}
	@Override // goods_no
	public int getGoodsNo(int cart_info_goods_no) {
		return sqlSession.selectOne("review.getGoodsNo", cart_info_goods_no);
	}
	@Override // 리뷰 파일 입력
	public void reviewFilesInsert(GoodsReviewFilesDto goodsReviewFilesDto) {
		sqlSession.insert("review.insertFiles", goodsReviewFilesDto);
	}
	@Override // 리뷰 목록
	public List<GoodsReviewDto> getReview(int goods_no) {
		return sqlSession.selectList("review.getReview", goods_no);
	}
	@Override // 리뷰 평점
	public int getStarAvg(int goods_no) {
		return sqlSession.selectOne("review.getStarAvg", goods_no);
	}
	
	@Override // 파일 출력
	public List<FilesVO> getFilesNo(int goods_no) {
		return sqlSession.selectList("review.getFilesNo", goods_no);
	}
	
//	리뷰 댓글	
	@Override // 리다이렉트용
	public int getGoodsNoReview(int goods_review_no) {
		return sqlSession.selectOne("review.getGoodsNoReview", goods_review_no);
	}
	@Override
	public void insertReviewReply(GoodsReviewReplyDto goodsReviewReplyDto) {
		sqlSession.insert("review.insertReply", goodsReviewReplyDto);
	}

}
