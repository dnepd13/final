package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.entity.GoodsReviewFilesDto;

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
	@Override // ordering no
	public int getOrderingNo(int cart_info_no) {
		return sqlSession.selectOne("review.getOrderingNo", cart_info_no);
	}
	@Override // goods_no
	public int getGoodsNo(int cart_info_no) {
		return sqlSession.selectOne("review.getGoodsNo", cart_info_no);
	}
	@Override // 리뷰 파일 입력
	public void reviewFilesInsert(GoodsReviewFilesDto goodsReviewFilesDto) {
		sqlSession.insert("review.insertFiles", goodsReviewFilesDto);
	}
	@Override // 리뷰 목록
	public List<GoodsReviewDto> getReview(int goods_no) {
		return sqlSession.selectList("review.getReview", goods_no);
	}
}
