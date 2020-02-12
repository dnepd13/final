package com.kh.admin.repository;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.vo.GoodsVO;
import com.kh.admin.vo.SellerGoodsVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class GoodsDaoImpl implements GoodsDao{

	@Autowired
	private SqlSession sqlSession;
	@Override
	public List<GoodsVO> getGoodsVO() {
		List<GoodsVO> list = sqlSession.selectList("admin.getGoodsVO");
		return list;
	}
	@Override
	public List<SellerGoodsVO> listGoods() {
		List<SellerGoodsVO> list = sqlSession.selectList("admin.goodsList");
		log.info("list={}",list);
		return list;
	}
	
}
