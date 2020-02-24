package com.kh.ordering.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.repository.DeliveryDao;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.GoodsOptionDao;
import com.kh.ordering.vo.CartVO;
import com.kh.ordering.vo.ItemVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class GoodsOptionService {

	@Autowired
	private DeliveryDao deliveryDao;
	
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
		log.info("list={}",list);
		for(ItemVO itemVO : list) {
			if(itemVO.getOption_no_list() != null) {
				log.info("itemVO={}",itemVO);
				CartVO cartVO = new CartVO();
				cartVO.setGoodsDto(goodsDao.get(itemVO.getGoods_no()));
				cartVO.setOption_list(goodsOptionDao.getList(itemVO.getOption_no_list()));
				cartVO.setPrice(itemVO.getPrice());
				cartVO.setQuantity(itemVO.getQuantity());
				cartVO.setDeliveryDto(deliveryDao.get2(itemVO.getGoods_no()));
				cartVOList.add(cartVO);
			}
		}
		
		return cartVOList;
	}
}
