package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.GoodsDto;

public class GoodsDaoImpl implements GoodsDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(GoodsDto goodsDto) {
		sqlSession.insert("goods.insert", goodsDto);
	}
	
	@Override
	public void delete(int goods_no) {
		sqlSession.delete("goods.delete", goods_no);
	}
	
	@Override
	public GoodsDto get(int goods_no) {
		return sqlSession.selectOne("goods.get", goods_no);
	}
	
	@Override
	public List<GoodsDto> getList() {
		return sqlSession.selectList("goods.getList");
	}
	
	@Override
	public int getSequenct() {
		return sqlSession.selectOne("goods.getSequence");
	}
}
