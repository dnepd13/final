package com.kh.ordering.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.GoodsOptionDao;
import com.kh.ordering.vo.CartVO;
import com.kh.ordering.vo.ItemVO;

public class GoodsOptionService {
	
	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	@Autowired
	private GoodsDao goodsDao;
	
	public void insert(GoodsOptionDto goodsOptionDto) {
		goodsOptionDao.insert(goodsOptionDto);
	}
	
	public void delete(int goods_option_no) {
		goodsOptionDao.delete(goods_option_no);
	}
	
	public GoodsOptionDto get(int goods_option_no) {
		return goodsOptionDao.get(goods_option_no);
	}
	
	public List<GoodsOptionDto> getList() {
		return goodsOptionDao.getList();
	}
	
//	public List<GoodsOptionDto> getList(List<Integer> list) {
//		return goodsOptionDao.getList(list);
//	}
	
	public List<CartVO> getCartVOList(List<ItemVO> list){
		List<CartVO> cartVOList = new ArrayList<>();
		for(ItemVO itemVO : list) {
			CartVO cartVO = new CartVO();
			cartVO.setGoodsDto(goodsDao.get(itemVO.getGoods_no()));
			cartVO.setOption_list(goodsOptionDao.getList(itemVO.getOption_no_list()));
			cartVO.setPrice(itemVO.getPrice());
			cartVO.setQuantity(itemVO.getQuantity());
			cartVOList.add(cartVO);
		}
		
		return cartVOList;
	}
}
