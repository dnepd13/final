package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.GoodsOptionDto;

public class GoodsOptionDaoImpl implements GoodsOptionDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(GoodsOptionDto goodsOptionDto) {
		sqlSession.insert("goods_option.insert", goodsOptionDto);
	}
	
	@Override
	public void delete(int goods_option_no) {
		sqlSession.delete("goods_option.delete", goods_option_no);
	}
	
	@Override
	public GoodsOptionDto get(int goods_option_no) {
		return sqlSession.selectOne("goods_option.get", goods_option_no);
	}
	
	@Override
	public List<GoodsOptionDto> getList() {
		return sqlSession.selectList("goods_option.getList");
	}
	
	@Override
	public int getSequence() { // 마지막 시퀀스 반환(currval)
		return sqlSession.selectOne("goods_option.getSequence");
	}
}
