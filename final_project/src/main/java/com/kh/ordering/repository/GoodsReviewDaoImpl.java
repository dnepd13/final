package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.entity.GoodsReviewFilesDto;
import com.kh.ordering.entity.GoodsReviewReplyDto;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

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
	public List<GoodsReviewDto> getReview(PagingVO pagingVO) {
		return sqlSession.selectList("review.getReview", pagingVO);
	}
	@Override
	public int getCount(int goods_no) {
		return sqlSession.selectOne("review.getCount", goods_no);
	}
	@Override // 리뷰 평점
	public int getStarAvg(int goods_no) {
		if(sqlSession.selectOne("review.getStarAvg", goods_no) != null) {
			return sqlSession.selectOne("review.getStarAvg", goods_no);
		} else {
			return 0; 
		}
	}
	
	@Override // 파일 출력
	public List<FilesVO> getFilesNo(int goods_review_no) {
				
		return sqlSession.selectList("review.getFilesNo", goods_review_no);
	}
	
//	리뷰 댓글	
	@Override // 리다이렉트용
	public int getGoodsNoReview(int goods_review_no) {
		return sqlSession.selectOne("review.getGoodsNoReview", goods_review_no);
	}
	@Override // 댓글 입력
	public void insertReviewReply(GoodsReviewReplyDto goodsReviewReplyDto) {
		sqlSession.insert("review.insertReply", goodsReviewReplyDto);
	}
	@Override // 댓글 목록
	public List<GoodsReviewReplyDto> getListReply(int goods_review_no) {
		return sqlSession.selectList("review.getListReply", goods_review_no);
	}
	@Override // 댓글 수정
	public void updateReviewReply(GoodsReviewReplyDto goodsReviewReplyDto) {
		sqlSession.update("review.updateReply", goodsReviewReplyDto);
	}
	@Override // 댓글 삭제
	public void deleteReviewReply(int goods_review_reply_no) {
		sqlSession.delete("review.deleteReply", goods_review_reply_no);
	}

}
