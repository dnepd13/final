package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.GoodsQnaDto;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class GoodsQnaDaoImpl implements GoodsQnaDao {

	@Autowired
	private SqlSession sqlSession;
	

	@Override // 상품에서 seller_no가져오기
	public int getSeller(int goods_no) {
		return sqlSession.selectOne("goods.getSeller", goods_no);
	}
	@Override // qna_no 단일조회
	public GoodsQnaDto getQna(int goods_qna_no) {		
		return sqlSession.selectOne("goods.getQna", goods_qna_no);
	}
	
	@Override // 회원 문의 작성
	public void insertQ(GoodsQnaDto goodsQnaDto) {
		sqlSession.insert("goods.insertQ", goodsQnaDto);
	}
	@Override // 회원 문의 수정
	public void updateQ(GoodsQnaDto goodsQnaDto) {
		sqlSession.update("goods.updateQ", goodsQnaDto);
	}
	@Override // 회원 문의 삭제
	public void deleteQ(GoodsQnaDto goodsQnaDto) {
		sqlSession.delete("goods.deleteQ", goodsQnaDto);
	}

	@Override // 상품 문의게시판 목록
	public List<GoodsQnaDto> getListQna(PagingVO pagingVO) {		
		return sqlSession.selectList("goods.getListQna", pagingVO);
	}

	@Override // 판매자 답변 작성
	public void insertA(GoodsQnaDto goodsQnaDto) {
		sqlSession.insert("goods.insertA",goodsQnaDto);
	}

	@Override // QnA 글 총 개수
	public int goodsQnaCount(int goods_no) {
		return sqlSession.selectOne("goods.getQnaCount", goods_no);
	}

	@Override // 답변이 있는지 없는지 계산하는 로직
	public void getIsQna(int goods_qna_groupno) {		
		sqlSession.update("goods.getIsQna", goods_qna_groupno);
	}

}
