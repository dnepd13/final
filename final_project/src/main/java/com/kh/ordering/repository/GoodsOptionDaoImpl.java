package com.kh.ordering.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.vo.GoodsOptionStockVO;
import com.kh.ordering.vo.GoodsOptionVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class GoodsOptionDaoImpl implements GoodsOptionDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void plusStock(int goods_option_no, int stock) {
		GoodsOptionStockVO goodsOptionStockVO = GoodsOptionStockVO.builder()
					.goods_option_no(goods_option_no)
					.goods_option_stock(stock)
				.build();
		sqlSession.update("goods_option.plusStock", goodsOptionStockVO);
	}
	
	@Override
	public boolean minusStock(int goods_option_no, int stock) {
		if(this.getStock(goods_option_no) >= stock) {
			GoodsOptionStockVO goodsOptionStockVO = GoodsOptionStockVO.builder()
						.goods_option_no(goods_option_no)
						.goods_option_stock(stock)
					.build();
			sqlSession.update("goods_option.minusStock", goodsOptionStockVO);
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public int getStock(int goods_option_no) {
		return sqlSession.selectOne("goods_option.getStock", goods_option_no);
	}
	
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
	public List<GoodsOptionDto> getList(int goods_no) {
		return sqlSession.selectList("goods_option.search", goods_no);
	}
	
	@Override
	public List<GoodsOptionDto> getList(List<Integer> list) {
		List<GoodsOptionDto> optionList = new ArrayList<>();
		for(int no : list) {
			optionList.add(this.get(no));
		}
		return optionList;
	}
	
	@Override
	public int getSequence() { // 마지막 시퀀스 반환(currval)
		return sqlSession.selectOne("goods_option.getSequence");
	}
	
	@Override
	public List<GoodsOptionVO> getGoodsOptionVOList(int goods_no) {
		List<GoodsOptionVO> goodsOptionVOList = new ArrayList<>();
		List<String> titleList = sqlSession.selectList("goods_option.getGoodsOpionTitleList", goods_no);
		
		for(int i=0; i<titleList.size(); i++) {
			goodsOptionVOList.add(i, new GoodsOptionVO());
			goodsOptionVOList.get(i).setGoods_option_title(titleList.get(i));
			Map<String, String> map = new HashMap<>();
			map.put("goods_option_title", titleList.get(i));
			map.put("goods_no", String.valueOf(goods_no));
			goodsOptionVOList.get(i).setGoodsOptionList(sqlSession.selectList("goods_option.getGoodsOptionList", map));
		}
		
		return goodsOptionVOList;
	}
	
}
