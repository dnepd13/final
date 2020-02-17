package com.kh.admin.repository;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.vo.GoodsCategoryVO;
import com.kh.admin.vo.GoodsVO;
import com.kh.admin.vo.PagingVO;
import com.kh.admin.vo.SellerGoodsVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class GoodsDaoImpl implements GoodsDao{

	@Autowired
	private SqlSession sqlSession;
	@Override
	public GoodsVO getGoodsVO(int goods_no) {
		GoodsVO list = sqlSession.selectOne("admin.getGoodsVO", goods_no);
		return list;
	}
	@Override
	public List<GoodsCategoryVO> listGoods(PagingVO vo) {
		List<GoodsCategoryVO> list = sqlSession.selectList("admin.goodsList", vo);
		log.info("list={}",list);
		return list;
	}
	@Override
	public int goodsCount() {
		return sqlSession.selectOne("admin.goodsCount");
	}
	@Override
	public void goodsDelete(GoodsVO goodsVO) {
		sqlSession.delete("admin.goodsDelete", goodsVO);
	}
	@Override
	public int goodsNameCount(String goods_name) {
		return sqlSession.selectOne("admin.goodsNameCount",goods_name);
	}
	@Override
	public int goodsIdCount(String seller_id) {
		return sqlSession.selectOne("admin.goodsIdCount",seller_id);
	}
	
}
